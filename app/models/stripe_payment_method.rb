class StripePaymentMethod < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :client, optional: true
  
  before_destroy :replace_favorite_card, if: -> { favorite }
  before_save :retrieve_stripe_details_then_attach, if: -> { stripe_payment_method_id_changed? }
  after_save :set_as_favorite, if: -> { favorite || customer.stripe_payment_methods.count == 1 }

  scope :active, -> { where('exp_date > ?', Date.today).order(exp_date: :desc) }
  scope :favorite, -> { where(favorite: true) }

  def replace_favorite_card
    new_favorite_card = customer.stripe_payment_methods.where(favorite: false).active.try(:first)
    new_favorite_card.update(favorite: true) if new_favorite_card.present?
  end


  def retrieve_stripe_details_then_attach
    if name.blank? || country.blank? || exp_month.blank? || exp_year.blank? || last_4.blank? || brand.blank?
      begin
        stripe_pm = Stripe::PaymentMethod.retrieve(
          stripe_payment_method_id,
        )
      rescue Exception => e
        SlackNotifierService.new('errors-prod', e).send_message
      end
      if stripe_pm.present?
        self.name = stripe_pm.billing_details.name if stripe_pm.billing_details.name.present?
        self.country = stripe_pm.card.country if stripe_pm.card.country.present?
        self.exp_month = stripe_pm.card.exp_month if stripe_pm.card.exp_month.present?
        self.exp_year = stripe_pm.card.exp_year if stripe_pm.card.exp_year.present?
        self.last_4 = stripe_pm.card.last4 if stripe_pm.card.last4.present?
        self.brand = stripe_pm.card.brand if stripe_pm.card.brand.present?
        self.payment_method_type = stripe_pm.type if stripe_pm.type.present?
        # yyyy-mm-dd
        self.exp_date = "20#{stripe_pm.card.exp_year.to_s.last(2)}/#{stripe_pm.card.exp_month}/01".to_date if stripe_pm.card.exp_month.present? && stripe_pm.card.exp_year.present?
      end
    end
    attach_to_customer
  end


  def attach_to_customer
    begin
      Stripe::PaymentMethod.attach(
        stripe_payment_method_id,
        { customer: customer.stripe_customer_id }
      )
    rescue => e
      SlackNotifierService.new('errors-prod', e).send_message
    end
  end

  def set_as_favorite
    update_columns(favorite: true) if !favorite # if not favorite but unique card
    Stripe::Customer.update(
      customer.stripe_customer_id,
      invoice_settings: {
        default_payment_method: stripe_payment_method_id
      }
    )
    customer.stripe_payment_methods.where.not(id: id).update_all(favorite: false)
  end

  def customer
    user || client
  end
end

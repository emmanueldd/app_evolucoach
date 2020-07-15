class Subscription < ApplicationRecord
  belongs_to :user
  before_update :change_stripe_price_id, if: -> { stripe_price_id_changed? }
  after_create :subscription_active_actions, if: -> { active? }
  # before_save :cancel, if: -> { status_changed? && canceled? }
  scope :still_active, -> { where('ends_on > ?', DateTime.now )}
  enum status: { incomplete: 0, incomplete_expired: 1, trialing: 2, active: 3, past_due: 4, canceled: 5, unpaid: 6 }

  def subscription_active_actions
    SubscriptionMailer.with(subscription: @subscription).subscription_paid_email.deliver_later
  end


  def renew_stripe_infos
    stripe_subscription = Stripe::Subscription.retrieve(stripe_subscription_id)
    if stripe_subscription.present?
      self.ends_on = DateTime.strptime(stripe_subscription.current_period_end.to_s,'%s')
      self.status = stripe_subscription.status
      self.save!
    end
  end

  def cancel
    if update(status: 'canceled', canceled_at: DateTime.now)
      begin
        deleted_subscription = Stripe::Subscription.delete(stripe_subscription_id)
      rescue => stripe_errors
        errors.add(:stripe, stripe_errors)
        return false
      end
    end
  end

  def change_stripe_price_id
    begin
      subscription = Stripe::Subscription.retrieve(stripe_subscription_id)
      updated_subscription = Stripe::Subscription.update(
        stripe_subscription_id,
        {
          cancel_at_period_end: false,
          items: [
            {
              id: subscription.items.data[0].id,
              price: stripe_price_id,
            },
          ],
        }
      )
    rescue => stripe_errors
      errors.add(:stripe, stripe_errors)
    end
  end

  def is_active?
    # trialing?
    active? && ends_on.present? && ends_on > DateTime.now
  end

  def self.create_subscription(user, subscription_params)
    stripe_price_id = subscription_params[:stripe_price_id]
    # Subscription should begin after the "ends_on" of the previous subscription if there is one.
    if user.subscription.present? && user.subscription.ends_on > DateTime.now
      trial_ends_on = user.subscription.ends_on.to_i
    else
      trial_ends_on = (DateTime.now + 30.days).to_i
    end
    stripe_subscription = Stripe::Subscription.create(
      customer: user.find_or_create_stripe_customer_id,
      items: [
        {
          price: stripe_price_id
        }
      ],
      expand: ['latest_invoice.payment_intent'],
      trial_end: trial_ends_on
    )
    @subscription = user.subscriptions.create(
      stripe_subscription_id: stripe_subscription.id,
      stripe_price_id: stripe_price_id,
      ends_on: DateTime.strptime(stripe_subscription.current_period_end.to_s,'%s'),
      status: stripe_subscription.status,
      started_at: DateTime.strptime(stripe_subscription.created.to_s,'%s'),
      trial_ends_on: DateTime.strptime(stripe_subscription.trial_end.to_s,'%s')
    )
    return @subscription
  end

end

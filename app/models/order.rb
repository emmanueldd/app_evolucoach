class Order < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :user
  has_many :order_has_items
  has_many :programs, through: :order_has_items, source: :item, source_type: 'Program'
  has_many :packs, through: :order_has_items, source: :item, source_type: 'Pack'
  has_many :order_has_courses, inverse_of: :order
  has_one :course
  has_many :courses, through: :order_has_courses
  accepts_nested_attributes_for :order_has_courses, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :courses, reject_if: :all_blank, allow_destroy: true
  before_save :alma_state_actions, if: -> { alma_state_changed? && alma_state.present? }
  after_update :set_credit_left, if: -> { !saved_change_to_credit_left? && packs.present? }
  after_save :set_course_infos
  after_save :set_paid_actions, if: -> { saved_change_to_status? && paid? }
  # When a client initiates a payment, it starts at incoming, when a coach/user creates it, it starts at waiting (for the payment)
  enum status: { incoming: 0, waiting: 1, paid: 2, failed: 3, refunded: 4 }
  scope :of_month, -> (date = DateTime.now) {
    where(paid_at: date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day)
  }
  scope :paid_with_credits, -> { paid.where('credit_left > ?', 0) }
  scope :waiting_or_paid, -> { where('status > ?', 0) }

  def show_calendly_after_payment?
    order_has_items.find_each do |order_has_item|
      return true if order_has_item.item.show_calendly_after_payment
    end
    false
  end

  def show_calendly_before_payment?
    order_has_items.find_each do |order_has_item|
      return true if order_has_item.item.show_calendly_before_payment
    end
    false
  end


  def alma_state_actions
    # ['not_started', 'scored_no', 'scored_maybe', 'scored_yes', 'paid']
    # if alma_state == 'new'
    #
    # els
    if alma_state == 'not_started'
      # Email votre paiement est en attente de validation
      OrderMailer.with(order: self).alma_payment_user_email.deliver_later
      OrderMailer.with(order: self).alma_payment_client_email.deliver_later
    elsif alma_state == 'scored_no'
      # Alma envoie un Email pour paiement en une fois ?
    elsif alma_state == 'scored_maybe'
      # Alma envoie un Email pour récolter plus d'informations ?
    elsif alma_state == 'scored_yes'
      # Email de confirmation via le status paid
      self.status = 'paid' # => Va call set_paid_actions, qui va call l'email
    elsif alma_state == 'paid'
      # Set_paid_actions s'en occupe
      # Email pour un autre pack ave un code promo ?
    end
  end

  def alma_uncomplete?
    (alma_state == 'new' || alma_state.blank?) # && alma_payment_id.present?
  end

  def name
    item.display_name
  end

  def set_paid_actions
    # BUG
    courses.where(status: 'pending').update(status: 'confirmed')
    @crm = client.user_has_clients.find_by(user: user)
    @crm.update!(has_buy: true) if @crm.present?
    @stat = user.stats.find_or_initialize_by(period: Date.today.end_of_month, name: 'income')
    if @stat.present?
      @stat.stat_value = user.orders.paid.of_month.sum(:total_price) / 100
      @stat.save!
    end

    OrderMailer.with(order: self).order_paid_user_email.deliver_later
    OrderMailer.with(order: self).order_paid_client_email.deliver_later
  end

  def set_course_infos
    # A optimiser
    client.update_columns(last_pack_purchased: "Pack #{packs.last.name}") if packs.present?
    courses.where(status: ['pending', 'confirmed']).order(start_time: :asc).each_with_index do |course, index|
      i = index + 1
      course.update_columns(course_infos: "#{i}/#{credit} pack #{packs.last.name}")
    end
  end


  def set_total_price
    self.total_price = order_has_items.sum('quantity * price')
  end

  def price
    total_price
  end

  def set_credit_left
    credit_left = credit - courses.not_removed.count
    update_columns(credit_left: credit_left)
    # Décrémenter  @crm.update!(coachings_left: user.orders.paid.sum(:credit_left) )
    # Ah bah non, les coachings left c'est le nombre de coachings à venir + credits left
    # Et les count sont ceux qui ont déjà été faits.
  end


  accepts_nested_attributes_for :order_has_items

  def item
    order_has_items.last.item if order_has_items.present?
  end

  def item_type
    return item.class.name == 'Pack' ? 'Pack' : 'Programme'
  end

  def item_title
    return "#{item_type} : #{item.name}"
  end
end

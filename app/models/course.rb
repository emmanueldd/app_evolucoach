class Course < ApplicationRecord
  attr_accessor :set_changed_recently_at
  belongs_to :user, optional: true
  belongs_to :client, optional: true
  belongs_to :availability, optional: true
  belongs_to :order
  # courses from orders paid changed have a changed_recently_at :
  # before_save :set_changed_recently_at, if: -> { order.paid? }
  before_save :set_fields
  after_save :set_availability, if: -> { saved_change_to_status? }
  enum status: { pending: 0, confirmed: 1, refused: 2, canceled: 3, removed: 4, done: 5 }
  scope :coming, -> { where('start_time > ?', DateTime.now ).order(start_time: :asc) }
  scope :done, -> { where('start_time < ?', DateTime.now ).order(start_time: :asc) }
  scope :confirmed_removed_canceled, -> { where(status: ['confirmed', 'removed', 'canceled']) }
  scope :changed_recently, -> { where.not(changed_recently_at: nil) }

  def set_fields
    # TODO : Dégueulasse, autant faire un delegate avec order. Mais reste interessant pour activeadmin
    # self.status = 'confirmed' if order.paid?
    self.user = order.user if order.present?
    self.client = order.client if order.present?
    self.changed_recently_at = DateTime.now if set_changed_recently_at && order.present? && order.paid?
  end

  # Worker, every 1h
  def self.send_courses_changed_recently_to_user
    @orders = Order.where(id: Course.changed_recently.select(:order_id).group(:order_id).pluck(:order_id))
    @orders.each do |order|
      OrderMailer.with(order: order).client_changed_coachings_user_email.deliver_later
      prev_order_id = order.id
    end
  end

  def set_availability
    availability.update(taken: (confirmed? || done?)) if availability.present?
  end

  def confirmed_or_done?
    return confirmed? || done?
  end

  def self.not_removed
    where.not(status: [3, 4])
  end

  def self.not_canceled
    where.not(status: 'canceled')
  end

  def self.are_confirmed
    where.not(status: 'confirmed')
  end
end

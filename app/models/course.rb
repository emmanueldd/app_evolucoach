class Course < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :client, optional: true
  belongs_to :availability, optional: true
  belongs_to :order
  before_save :set_fields
  after_save :set_availability, if: -> { saved_change_to_status? }
  enum status: { pending: 0, confirmed: 1, refused: 2, canceled: 3, removed: 4, done: 5 }
  scope :coming, -> { where('start_time > ?', DateTime.now ).order(start_time: :asc) }
  scope :done, -> { where('start_time < ?', DateTime.now ).order(start_time: :asc) }

  def set_fields
    # TODO : Dégueulasse, autant faire un delegate avec order. Mais reste interessant pour activeadmin
    # self.status = 'confirmed' if order.paid?
    self.user = order.user if order.present?
    self.client = order.client if order.present?
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

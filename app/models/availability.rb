class Availability < ApplicationRecord
  belongs_to :user
  before_save :set_available, if: -> { taken_changed? }

  def set_available
    self.available = taken
  end

  def now
    return (Time.now..Time.now + 59.minutes).cover?(start_time)
  end

  def is_taken_for_coach?
    return start_time < DateTime.now # || (course.present? && !course.removed? && course.order.paid? && !course.canceled?)
  end

  def taken(order = nil)
    false
    # current_order = order.courses.where(availability_id: id).present? if order.present?
    # course = courses.joins(:order).where(status: [0, 1], orders: {status: 'paid'}).first
    # return start_time < DateTime.now || !available && !current_order || (course.present? && !course.canceled? && !course.removed? && course.order.paid? && !current_order)
    # true = taken, false = not taken
  end
end

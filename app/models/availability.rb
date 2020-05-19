class Availability < ApplicationRecord
  belongs_to :user
  before_save :set_available, if: -> { taken_changed? }

  def set_available
    self.available = taken
  end

  def now
    return (Time.now..Time.now + 59.minutes).cover?(start_time)
  end

  def is_taken_for_pro?
    return start_time < DateTime.now # || (course.present? && !course.removed? && course.order.paid? && !course.canceled?)
  end
end

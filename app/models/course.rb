class Course < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :availability
  after_save :set_availability, if: -> { saved_change_to_status? }
  enum status: { confirmed: 0, refused: 1, canceled: 2 }

  def set_availability
    availability.update(taken: (confirmed? || done?)) if availability.present?
  end

  def confirmed_or_done?
    return confirmed? || done?
  end
end

class Exercise < ApplicationRecord
  belongs_to :exercise_category
  scope :published, -> { where(published: true) }
end

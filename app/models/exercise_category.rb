class ExerciseCategory < ApplicationRecord
  has_many :exercises
  has_many :program_steps
  scope :published, -> { where(published: true) }
end

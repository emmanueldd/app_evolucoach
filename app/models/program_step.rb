class ProgramStep < ApplicationRecord
  belongs_to :user
  belongs_to :program
  belongs_to :exercise
  belongs_to :exercise_category
  before_save :set_exercise_category_id, if: -> { exercise_category_id.nil? }

  def set_exercise_category_id
    self.exercise_category_id = exercise.exercise_category_id
  end
end

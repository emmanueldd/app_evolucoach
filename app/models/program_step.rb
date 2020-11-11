class ProgramStep < ApplicationRecord
  belongs_to :user
  belongs_to :program
  belongs_to :exercise
  belongs_to :exercise_category
  before_save :set_exercise_category_id, if: -> { exercise_category_id.nil? }
  after_save :set_exercise_count
  after_initialize :set_video_url

  def set_exercise_count
    same_exercise_program_steps = program.program_steps.where(exercise_id: exercise_id)
    same_exercise_program_steps.update_all(exercise_count: same_exercise_program_steps.count)
  end

  def set_exercise_category_id
    self.exercise_category_id = exercise.exercise_category_id
  end

  def set_video_url
    self.video_url ||= exercise.video_url
  end

end

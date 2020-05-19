class AddExerciseCategoryIdToProgramSteps < ActiveRecord::Migration[5.1]
  def change
    add_reference :program_steps, :exercise_category, foreign_key: true
  end
end

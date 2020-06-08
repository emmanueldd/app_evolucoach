class AddExerciseCountToProgramSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :program_steps, :exercise_count, :integer, default: 1
  end
end

class CreateProgramSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :program_steps do |t|
      t.references :user, foreign_key: true
      t.references :program, foreign_key: true
      t.references :exercise, foreign_key: true
      t.string :name
      t.integer :step_type
      t.boolean :published, default: false
      t.string :round
      t.string :repetition
      t.string :charge
      t.string :cadence

      t.timestamps
    end
  end
end

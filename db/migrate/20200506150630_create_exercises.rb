class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.references :exercise_category, foreign_key: true
      t.boolean :published, default: false

      t.timestamps
    end
  end
end

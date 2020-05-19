class CreateExeciseCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_categories do |t|
      t.string :name
      t.boolean :published, default: false

      t.timestamps
    end
  end
end

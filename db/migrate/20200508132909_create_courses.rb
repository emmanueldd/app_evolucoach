class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.references :availability, foreign_key: true
      t.datetime :start_time
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

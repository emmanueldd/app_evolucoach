class CreateAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :availabilities do |t|
      t.references :user, foreign_key: true
      t.boolean :course
      t.datetime :start_time
      t.boolean :available, default: false
      t.boolean :taken, default: false

      t.timestamps
    end
  end
end

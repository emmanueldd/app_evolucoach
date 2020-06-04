class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.float :stat_value

      t.timestamps
    end
  end
end

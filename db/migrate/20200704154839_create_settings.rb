class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.string :setting_name
      t.string :setting_value

      t.timestamps
    end
  end
end

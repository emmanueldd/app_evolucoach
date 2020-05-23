class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :client, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status
      t.integer :total_price

      t.timestamps
    end
  end
end

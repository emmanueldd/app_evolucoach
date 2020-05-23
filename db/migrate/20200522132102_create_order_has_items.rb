class CreateOrderHasItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_has_items do |t|
      t.references :order, foreign_key: true
      t.references :item, polymorphic: true
      t.integer :quantity
      t.integer :total_price

      t.timestamps
    end
  end
end

class ChangeColumnTypeForPrices < ActiveRecord::Migration[5.1]
  def up
    change_column :orders, :total_price, :decimal, precision: 8, scale: 2
    change_column :online_offers, :price, :decimal, precision: 8, scale: 2
    change_column :programs, :price, :decimal, precision: 8, scale: 2
    change_column :packs, :price, :decimal, precision: 8, scale: 2, default: 0
    change_column :packs, :unit_price, :decimal, precision: 8, scale: 2
    change_column :order_has_items, :price, :decimal, precision: 8, scale: 2
    change_column :users, :financial_goal, :decimal, precision: 8, scale: 2, default: 0
  end
  def down
    change_column :orders, :total_price, :integer
    change_column :online_offers, :price, :integer
    change_column :programs, :price, :integer
    change_column :packs, :price, :integer, default: 0
    change_column :packs, :unit_price, :integer
    change_column :order_has_items, :price, :integer
    change_column :users, :financial_goal, :integer, default: 0
  end
end

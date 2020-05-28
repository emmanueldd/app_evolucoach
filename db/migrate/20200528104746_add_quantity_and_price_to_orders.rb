class AddQuantityAndPriceToOrders < ActiveRecord::Migration[5.1]
  def change
    rename_column :order_has_items, :total_price, :price
  end
end

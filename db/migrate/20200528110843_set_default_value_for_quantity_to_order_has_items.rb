class SetDefaultValueForQuantityToOrderHasItems < ActiveRecord::Migration[5.1]
  def up
    change_column_default :order_has_items, :quantity, 1
  end

  def down
    change_column_default :order_has_items, :quantity, nil
  end
end

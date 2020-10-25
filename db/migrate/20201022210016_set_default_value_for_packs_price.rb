class SetDefaultValueForPacksPrice < ActiveRecord::Migration[5.1]
  def up
    change_column_default :packs, :price, 0
    Pack.where(price: nil).update_all(price: 0)
  end

  def down
    change_column_default :packs, :price, nil
    Pack.where(price: 0).update_all(price: nil)
  end
end

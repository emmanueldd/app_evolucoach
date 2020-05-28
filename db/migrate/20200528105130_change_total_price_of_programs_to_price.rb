class ChangeTotalPriceOfProgramsToPrice < ActiveRecord::Migration[5.1]
  def change
    rename_column :packs, :total_price, :price
  end
end

class AddPeriodToStats < ActiveRecord::Migration[5.1]
  def change
    add_column :stats, :period, :date
  end
end

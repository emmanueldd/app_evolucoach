class AddAvgMonthlyIncomeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avg_monthly_income, :integer, default: 0
  end
end

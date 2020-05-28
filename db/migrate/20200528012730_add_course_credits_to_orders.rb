class AddCourseCreditsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :credit, :integer, default: 0
    add_column :orders, :credit_left, :integer, default: 0
  end
end

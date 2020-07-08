class AddAlmaStateToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :alma_state, :string
  end
end

class AddAlmaPaymentIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :alma_payment_id, :string
  end
end

class AddBusinessStateToPaymentInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :payment_infos, :business_state, :string
    add_column :payment_infos, :contact_state, :string
  end
end

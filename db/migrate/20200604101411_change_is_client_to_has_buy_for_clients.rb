class ChangeIsClientToHasBuyForClients < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_has_clients, :is_client, :has_buy
  end
end

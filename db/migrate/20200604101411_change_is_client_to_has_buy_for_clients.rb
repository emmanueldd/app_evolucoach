class ChangeIsClientToHasBuyForClients < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_has_clients, :has_buy, :has_buy
  end
end

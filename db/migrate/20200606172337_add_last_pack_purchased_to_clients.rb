class AddLastPackPurchasedToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :last_pack_purchased, :string
  end
end

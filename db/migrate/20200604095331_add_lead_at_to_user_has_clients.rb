class AddLeadAtToUserHasClients < ActiveRecord::Migration[5.1]
  def change
    add_column :user_has_clients, :lead_at, :datetime
    add_column :user_has_clients, :client_at, :datetime
  end
end

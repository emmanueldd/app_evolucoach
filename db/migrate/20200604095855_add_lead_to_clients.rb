class AddLeadToClients < ActiveRecord::Migration[5.1]
  def change
    add_reference :clients, :lead, foreign_key: true
  end
end

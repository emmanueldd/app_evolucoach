class AddFieldsToClients < ActiveRecord::Migration[5.1]
  def change
    add_reference :clients, :user, foreign_key: true
    add_column :clients, :city, :string
    add_column :clients, :address, :string
    add_column :clients, :country, :string
    add_column :clients, :dpt, :string
    add_column :clients, :zipcode, :string
    add_column :clients, :birth_date, :date
  end
end

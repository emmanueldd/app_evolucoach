class AddFieldswujToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :country, :string
    add_column :users, :dpt, :string
    add_column :users, :zipcode, :string
    add_column :users, :birth_date, :date
    add_column :users, :male, :boolean, default: false
  end
end

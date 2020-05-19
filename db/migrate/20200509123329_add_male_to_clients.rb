class AddMaleToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :male, :boolean
    add_column :leads, :male, :boolean
    add_column :clients, :age, :integer
    add_column :leads, :age, :integer
  end
end

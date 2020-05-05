class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nickname, :string, default: ''
    add_column :users, :first_name, :string, default: ''
    add_column :users, :last_name, :string, default: ''
    add_column :users, :description, :text, default: ''
    add_column :users, :financial_goal, :integer, default: 0
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
    add_column :users, :phone, :string
    add_column :users, :avatar, :string
  end
end

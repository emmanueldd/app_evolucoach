class AddCurrentSignInAtToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet
    add_column :clients, :sign_in_count, :integer, default: 0, null: false
    add_column :clients, :current_sign_in_at, :datetime
    add_column :clients, :last_sign_in_at, :datetime
    add_column :clients, :current_sign_in_ip, :inet
    add_column :clients, :last_sign_in_ip, :inet
  end

  def down
    remove_columns :users, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
    remove_columns :clients, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
  end
end

class CreateUserHasClients < ActiveRecord::Migration[5.1]
  def change
    create_table :user_has_clients do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.references :lead, foreign_key: true
      t.boolean :has_buy, default: false

      t.timestamps
    end
  end
end

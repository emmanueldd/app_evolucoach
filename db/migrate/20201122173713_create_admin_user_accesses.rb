class CreateAdminUserAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_user_accesses do |t|
      t.string :name
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end

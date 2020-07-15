class ChangeOrderIdTypeToUuid < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
    add_column :orders, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :orders, :uuid
  end
end
# class ChangeOrderIdTypeToUuid < ActiveRecord::Migration[5.1]
#   def up
#     enable_extension 'pgcrypto'
#     # Add UUID columns
#     add_column :orders,    :uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }
#     # add_column :order_has_items, :uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }
#
#     # Add UUID columns for associations
#     add_column :order_has_items, :order_uuid, :uuid
#
#     # Populate UUID columns for associations
#     execute <<-SQL
#       UPDATE order_has_items SET order_uuid = orders.uuid
#       FROM orders WHERE order_has_items.order_id = orders.id;
#     SQL
#
#     # Change null
#     change_column_null :order_has_items, :order_uuid, false
#
#     # Migrate UUID to ID for associations
#     remove_column :order_has_items, :order_id
#     rename_column :order_has_items, :order_uuid, :order_id
#
#     # Add indexes for associations
#     add_index :order_has_items, :order_id
#
#     # Add foreign keys
#     add_foreign_key :order_has_items, :orders
#
#     # Migrate primary keys from UUIDs to IDs
#     remove_column :orders,    :id
#     # remove_column :order_has_items, :id
#     rename_column :orders,    :uuid, :id
#     # rename_column :order_has_items, :uuid, :id
#     execute "ALTER TABLE orders    ADD PRIMARY KEY (id);"
#     # execute "ALTER TABLE order_has_items ADD PRIMARY KEY (id);"
#
#     # Add indexes for ordering by date
#     add_index :orders,    :created_at
#     add_index :order_has_items, :created_at
#   end
#
#   def down
#     raise ActiveRecord::IrreversibleMigration
#   end
# end

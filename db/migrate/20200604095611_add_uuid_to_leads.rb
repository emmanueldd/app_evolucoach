class AddUuidToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :uuid, :string
    add_index :leads, :uuid, unique: true
  end
end

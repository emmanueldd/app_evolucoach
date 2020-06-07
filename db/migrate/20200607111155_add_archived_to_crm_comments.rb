class AddArchivedToCrmComments < ActiveRecord::Migration[5.1]
  def change
    add_column :crm_comments, :archived, :boolean, default: false
  end
end

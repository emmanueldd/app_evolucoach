class AddNameToCrmComments < ActiveRecord::Migration[5.1]
  def change
    add_column :crm_comments, :name, :string
  end
end

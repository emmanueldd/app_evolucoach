class CreateCrmComments < ActiveRecord::Migration[5.1]
  def change
    create_table :crm_comments do |t|
      t.references :user, foreign_key: true
      t.references :user_has_client, foreign_key: true
      t.references :client, foreign_key: true
      t.text :comment
      t.boolean :published, default: false

      t.timestamps
    end
  end
end

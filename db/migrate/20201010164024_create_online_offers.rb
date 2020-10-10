class CreateOnlineOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :online_offers do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.references :user_has_client, foreign_key: true
      t.string :name
      t.string :slug
      t.text :description
      t.integer :price
      t.boolean :published
      t.string :cover

      t.timestamps
    end
  end
end

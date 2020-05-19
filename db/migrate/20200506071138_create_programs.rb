class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.string :name
      t.string :slug
      t.text :description
      t.integer :price
      t.boolean :published, default: true

      t.timestamps
    end
    add_index :programs, :slug, unique: true
  end
end

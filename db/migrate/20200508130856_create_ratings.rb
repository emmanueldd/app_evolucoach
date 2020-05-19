class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.integer :score
      t.text :comment, default: ''
      t.boolean :published, default: true

      t.timestamps
    end
  end
end

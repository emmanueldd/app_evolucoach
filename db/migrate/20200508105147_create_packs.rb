class CreatePacks < ActiveRecord::Migration[5.1]
  def change
    create_table :packs do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :description
      t.string :bg_color
      t.integer :position, default: 0
      t.string :color
      t.string :pack_type
      t.integer :unit_price
      t.integer :total_price
      t.integer :nb_of_courses


      t.timestamps
    end
  end
end

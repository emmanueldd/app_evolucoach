class CreateAffiliateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliate_codes do |t|
      t.string :name
      t.decimal :value
      t.integer :usage_count, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :affiliate_codes, :name, unique: true
  end
end

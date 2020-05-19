class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.references :user, foreign_key: true
      t.string "email", default: "", null: false
      t.string "first_name", default: ""
      t.string "last_name", default: ""
      t.string "slug"
      t.string "phone"
      t.string "avatar"
      t.string "nickname"
      t.string "city"
      t.string "address"
      t.string "country"
      t.string "dpt"
      t.string "zipcode"
      t.date "birth_date"

      t.timestamps
    end
  end
end

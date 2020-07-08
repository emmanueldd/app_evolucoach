class CreateStripePaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_payment_methods do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.string   "stripe_payment_method_id"
      t.boolean  "favorite"
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
      t.string   "name"
      t.string   "country"
      t.string   "exp_month"
      t.string   "exp_year"
      t.string   "last_4"
      t.string   "brand"
      t.string   "payment_method_type"
      t.date     "exp_date"
      t.timestamps
    end
  end
end

class CreateStripeCustomerIds < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_customer_ids do |t|
      t.string :customer_id
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.string :stripe_subscription_id
      t.datetime :ends_on
      t.datetime :started_at
      t.datetime :canceled_at
      t.integer :status, default: 0
      t.string :stripe_price_id

      t.timestamps
    end
  end
end

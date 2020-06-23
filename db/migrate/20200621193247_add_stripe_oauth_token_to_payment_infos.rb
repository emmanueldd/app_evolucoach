class AddStripeOauthTokenToPaymentInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :payment_infos, :stripe_oauth_token, :string
  end
end

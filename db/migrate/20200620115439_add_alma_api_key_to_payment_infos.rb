class AddAlmaApiKeyToPaymentInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :payment_infos, :alma_api_key, :string
  end
end

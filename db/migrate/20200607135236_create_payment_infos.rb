class CreatePaymentInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_infos do |t|
      t.references :user, foreign_key: true
      t.string   "stripe_account_id"
      t.string   "business_name"
      t.string   "business_address_1"
      t.string   "business_address_2"
      t.string   "business_zip_code"
      t.string   "business_city"
      t.string   "business_country"
      t.string   "siren"
      t.string   "business_tax_id"
      t.string   "first_name"
      t.string   "last_name"
      t.datetime "birth_date"
      t.string   "ss_number"
      t.string   "contact_address_1"
      t.string   "contact_address_2"
      t.string   "contact_zip_code"
      t.string   "contact_city"
      t.string   "contact_country"
      t.datetime "tos_acceptance_date"
      t.string   "tos_acceptance_ip"
      t.string   "tos_acceptance_user_agent"
      t.string   "iban"
      t.string   "transfer_schedule",         default: "monthly"
      t.string   "stripe_bank_account_id"
      t.string   "stripe_account_status"
      t.datetime "created_at",                                    null: false
      t.datetime "updated_at",                                    null: false
      t.integer  "place_id"
      t.boolean  "recurring_payments"
      t.boolean  "mandate_acceptance"
      t.string   "customer_id"
      t.string   "source_id"
      t.string   "mandate_url"
      t.string   "business_vat_id"
      t.string   "identity_card_front"
      t.string   "identity_card_back"

      t.timestamps
    end
  end
end

class PaymentInfo < ApplicationRecord
  belongs_to :user

  # def call
  #   begin
  #     country = ISO3166::Country.find_by_name(business_country.try(:strip)).first
  #     account = Stripe::Account.create(
  #         country: country,
  #         type: 'custom',
  #         business_name: business_name,
  #         email: user.email,
  #         external_account: {
  #             object: 'bank_account',
  #             country: country,
  #             currency: 'eur',
  #             account_number: iban # Test iban: 'FR89370400440532013000'
  #         },
  #         legal_entity: {
  #             additional_owners: nil,
  #             address: {
  #                 line1: business_address_1,
  #                 line2: business_address_2,
  #                 postal_code: business_zip_code,
  #                 city: business_city,
  #                 country: country
  #             },
  #             business_name: business_name,
  #             business_tax_id: business_tax_id,
  #             business_vat_id: business_vat_id,
  #             first_name: first_name,
  #             last_name: last_name,
  #             type: 'company',
  #             dob: {
  #                 day: birth_date.try(:day),
  #                 month: birth_date.try(:month),
  #                 year: birth_date.try(:year),
  #             },
  #             personal_address: {
  #                 line1: contact_address_1,
  #                 line2: contact_address_2,
  #                 postal_code: contact_zip_code,
  #                 city: contact_city
  #             },
  #         },
  #         payout_schedule: {
  #           interval: 'weekly',
  #           weekly_anchor: 'monday'
  #         },
  #         tos_acceptance: {
  #             date: tos_acceptance_date.to_time.to_i,
  #             ip: tos_acceptance_ip,
  #             user_agent: tos_acceptance_user_agent
  #         }
  #     )
  #
  #     update(stripe_account_id: account[:id], stripe_account_status: account[:legal_entity][:verification][:status])
  #     update(stripe_bank_account_id: account[:external_accounts][:data][0][:id]) if account[:external_accounts][:data].present?
  #     account.legal_entity.additional_owners = nil
  #     account.legal_entity.verification.document = UploadStripeDocument.new(identity_card_front_url, account.id).call if identity_card_front.present?
  #     account.legal_entity.verification.document_back = UploadStripeDocument.new(identity_card_back_url, account.id).call if identity_card_back.present?
  #
  #     account.save
  #         rescue Stripe::StripeError => e
  #     { error: e.message }
  #   end
  # end
end

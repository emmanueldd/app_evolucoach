class AddShowCalendlyToPacks < ActiveRecord::Migration[5.1]
  def change
    add_column :packs, :show_calendly_before_payment, :boolean, default: false
    add_column :packs, :show_calendly_after_payment, :boolean, default: false
    add_column :packs, :hide_payment_page, :boolean, default: false
    add_column :programs, :show_calendly_before_payment, :boolean, default: false
    add_column :programs, :show_calendly_after_payment, :boolean, default: false
    add_column :programs, :hide_payment_page, :boolean, default: false
    add_column :online_offers, :show_calendly_before_payment, :boolean, default: false
    add_column :online_offers, :show_calendly_after_payment, :boolean, default: false
    add_column :online_offers, :hide_payment_page, :boolean, default: false
  end
end

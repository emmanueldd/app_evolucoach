class AddCalendlyUrlToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :calendly_url, :string
  end
end

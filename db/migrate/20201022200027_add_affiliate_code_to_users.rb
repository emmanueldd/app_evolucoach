class AddAffiliateCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :affiliate_code, foreign_key: true
  end
end

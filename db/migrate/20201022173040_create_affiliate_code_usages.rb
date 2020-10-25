class CreateAffiliateCodeUsages < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliate_code_usages do |t|
      t.references :affiliate_code, foreign_key: true
      t.references :subscription, foreign_key: true
      t.references :user, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end

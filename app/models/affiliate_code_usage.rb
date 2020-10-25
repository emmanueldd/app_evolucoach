class AffiliateCodeUsage < ApplicationRecord
  belongs_to :affiliate_code
  belongs_to :subscription
  belongs_to :user

  before_save :set_fields

  def set_fields
    self.user = affiliate_code.user
  end
end

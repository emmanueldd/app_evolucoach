class CrmComment < ApplicationRecord
  belongs_to :user
  belongs_to :user_has_client
  belongs_to :client
end

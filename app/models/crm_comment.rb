class CrmComment < ApplicationRecord
  belongs_to :user
  belongs_to :user_has_client
  belongs_to :client, optional: true
  scope :published, -> { where(published: true, archived: false) }

  before_save :set_client

  def set_client
    self.client = user_has_client.client
  end
end

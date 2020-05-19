class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :client
  scope :published, -> { where(published: true) }
end

class Program < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :cover, CoverUploader
  belongs_to :user
  belongs_to :client, optional: true
  has_many :program_steps

  scope :published, -> { where(published: true) }

  def destroy
    update(published: false)
  end
end

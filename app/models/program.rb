class Program < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :cover, CoverUploader
  mount_uploader :file, FileUploader
  belongs_to :user
  belongs_to :client, optional: true
  belongs_to :user_has_client, optional: true
  has_many :program_steps
  has_many :order_has_items, as: :item
  has_many :orders, through: :order_has_items
  accepts_nested_attributes_for :user

  scope :published, -> { where(published: true, user_has_client: nil).reorder(price: :asc) }

  before_save :set_client, if: -> { user_has_client.present? }

  def self.show_name
    'programme'
  end

  def display_name
    "Programme - #{name}"
  end

  def set_client
    self.client = user_has_client.client
  end

  def destroy
    update(published: false)
  end
end

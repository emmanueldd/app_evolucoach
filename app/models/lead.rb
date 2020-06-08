class Lead < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :user, optional: true
  has_many :user_has_clients

  after_save :add_to_crm, if: -> { saved_change_to_user_id? }

  def add_to_crm
    user_has_clients.create!(user: user) if user.present?
  end

end

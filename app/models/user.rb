class User < ApplicationRecord
  extend FriendlyId
  friendly_id :first_name, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  mount_uploader :avatar, AvatarUploader
  has_many :ratings
  has_many :packs
  has_many :courses
  has_many :availabilities
  has_many :programs
  has_many :program_steps
  has_many :user_has_clients

  def self.validated
    all
  end

end

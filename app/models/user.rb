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
  has_many :crm_comments
  has_many :stats
  has_many :orders
  has_many :order_has_items, through: :orders
  has_one :payment_info
  after_save :create_payment_info

  def create_payment_info
    PaymentInfo.create_then_set_stripe_account(self)
  end

  def self.validated
    all
  end

end

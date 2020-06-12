class User < ApplicationRecord
  extend FriendlyId
  friendly_id :first_name, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable
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
  before_save :set_slug
  after_create :set_past_income_stats
  validate :is_account_allowed?, on: :create

  def set_slug
    if slug.present?
      self.slug = slug.downcase if slug_changed?
    # else
    #   self.slug = name.parameterize if name.present?
    end
  end

  def is_account_allowed?
    errors[:base] << "Ton email n'est pas celui d'un Evolucoach." unless AllowedAccount.exists?(email: email)
  end

  def set_past_income_stats
    8.times do |index|
      date = (Date.today - index.month).end_of_month
      stats.create(name: 'income', period: date, stat_value: 0)
    end
  end

  def self.validated
    all
  end

end

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
  has_many :subscriptions
  has_many :crm_comments
  has_many :stats
  has_many :orders
  has_many :order_has_items, through: :orders
  has_one :payment_info
  has_many :stripe_payment_methods
  before_save :set_fields
  after_create :set_past_income_stats
  after_create :info_anonymation, unless: -> { Rails.env.production? }
  validate :is_account_allowed?, on: :create

  def info_anonymation
    # After we pull production DB, we change the contacts (email and phone number).
    update_columns(email: "contact+#{slug}@evolucorp.com", phone: "0000#{phone}")
  end

  def find_or_create_stripe_customer_id
    if stripe_customer_id.blank?
      customer = Stripe::Customer.create(
        email: email
      )
      update_columns(stripe_customer_id: customer.id)
    end
    return stripe_customer_id
  end

  def subscription
    subscriptions.last
  end

  def subscribed?
    subscriptions.still_active.present?
    # || subscriptions.active.present? || subscriptions.trialing.present?
  end


  def set_fields
    if slug.present? && slug_changed?
      self.slug = slug.downcase.parameterize
    end
    if fb_pixel_code.present? && fb_pixel_code_changed?
      self.fb_pixel_code = fb_pixel_code.delete(' ').to_i.to_s
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

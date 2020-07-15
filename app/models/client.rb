class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  mount_uploader :avatar, AvatarUploader
  belongs_to :user, optional: true
  belongs_to :lead, optional: true
  has_many :orders
  has_many :order_has_items, through: :orders
  has_many :user_has_clients
  has_many :stripe_payment_methods
  has_many :stripe_customer_ids

  before_save :set_nickname, if: -> { first_name_changed? || last_name_changed? }
  before_save :set_age, if: -> { birth_date_changed? }
  before_save :set_address, if: -> { line1.present? || postal_code.present? || zipcode_changed? }
  after_save :add_to_crm, if: -> { saved_change_to_user_id? }

  scope :men, -> { where(male: true) }
  scope :women, -> { where(male: false) }

  attr_accessor :postal_code, :line1

  def set_address
    self.address = line1 if line1.present?
    self.zipcode = postal_code if postal_code.present?
    self.dpt = self.zipcode.first(2)
  end

  def add_to_crm
    if user.present? && lead.present?
      crm = UserHasClient.find_or_initialize_by(lead: lead, user: user)
      crm.client_id = id
      crm.save!
    end
  end

  def coachings_left
    orders.paid.sum(:credit_left)
  end

  def coachings_count
    orders.paid.sum(:credit) - coachings_left
  end

  def display_name
    "#{first_name} #{last_name} - #{email}"
  end

  def signup_completed?
    birth_date.present? && !male.nil? && phone.present? && city.present?
  end

  def programs
    # TODO : A SIMPLIFIER
    Program.where(id: order_has_items.joins(:order).where(item_type: 'Program', orders: {status: 'paid'}).pluck(:item_id))
  end

  def packs
    Program.where(id: order_has_items.joins(:order).where(item_type: 'Program', orders: {status: 'paid'}).pluck(:item_id))
  end

  def find_stripe_customer_id(user)
    connected_stripe_account_id = user.payment_info.stripe_account_id
    my_stripe_customer_id = stripe_customer_ids.find_by(user: user).try(:customer_id)
    if my_stripe_customer_id.blank?
      my_stripe_customer_id = create_stripe_customer_id(connected_stripe_account_id)
    end
    begin
      stripe_customer = Stripe::Customer.retrieve(
        stripe_customer_id,
        {
          stripe_account: connected_stripe_account_id,
        }
      )
    rescue => e
      my_stripe_customer_id = create_stripe_customer_id(connected_stripe_account_id)
    end
    return my_stripe_customer_id
  end

  def create_stripe_customer_id(connected_stripe_account_id = nil)
    customer = Stripe::Customer.create({
      email: email
    }, {
      stripe_account: connected_stripe_account_id,
    })
    stripe_customer_ids.create(user: user, customer_id: customer.id)
    return customer.id
  end


  def set_nickname
    if first_name.present? || last_name.present?
      self.nickname = "#{first_name} #{last_name[0..1]}."
    end
  end

  def set_age
    now = Date.today
    self.age = now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  def check_age
    # Robot qui va mettre à jour l'age
  end
end

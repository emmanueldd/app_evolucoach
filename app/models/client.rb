class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  mount_uploader :avatar, AvatarUploader
  belongs_to :user, optional: true
  has_many :orders
  has_many :order_has_items, through: :orders

  before_save :set_nickname, if: -> { first_name_changed? || last_name_changed? }
  before_save :set_age, if: -> { birth_date_changed? }

  def display_name
    "#{first_name} #{last_name} - #{email}"
  end

  def programs
    # TODO : A SIMPLIFIER
    Program.where(id: order_has_items.joins(:order).where(item_type: 'Program', orders: {status: 'paid'}).pluck(:item_id))
  end

  def packs
    Program.where(id: order_has_items.joins(:order).where(item_type: 'Program', orders: {status: 'paid'}).pluck(:item_id))
  end

  def find_stripe_customer_id
    if stripe_customer_id.blank?
      customer = Stripe::Customer.create(
        email: email
      )
      update_columns(stripe_customer_id: customer.id)
    end
    return stripe_customer_id
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

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  has_many :admin_user_accesses
  accepts_nested_attributes_for :admin_user_accesses, reject_if: :all_blank, allow_destroy: true
  after_create :set_default_admin_user_accesses

  def set_default_admin_user_accesses
    ['Exercise', 'Comment', 'Dashboard', 'Session'].each do |access|
      admin_user_accesses.find_or_create_by(name: access)
    end
  end
end

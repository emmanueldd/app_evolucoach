class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :order_has_items
  has_many :programs, through: :order_has_items, source: :item, source_type: 'Program'
  has_many :packs, through: :order_has_items, source: :item, source_type: 'Pack'
  has_many :order_has_courses, inverse_of: :order
  has_one :course
  has_many :courses, through: :order_has_courses
  accepts_nested_attributes_for :order_has_courses, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :courses, reject_if: :all_blank, allow_destroy: true
  enum status: { waiting: 0, paid: 1, failed: 2, refunded: 3 }
  after_update :set_credit_left, if: -> { !saved_change_to_credit_left? && packs.present? }
  after_save :set_course_infos
  after_save :set_paid_actions, if: -> { saved_change_to_status? && paid? }

  def set_paid_actions
    # BUG
    courses.where(status: 'pending').update(status: 'confirmed')
    @crm = client.user_has_clients.find_by(user: user)
    @crm.update(is_client: true) if @crm.present?
  end

  def set_course_infos
    # A optimiser
    courses.where(status: ['pending', 'confirmed']).order(start_time: :asc).each_with_index do |course, index|
      i = index + 1
      course.update_columns(course_infos: "#{i}/#{credit} pack #{packs.last.name}")
    end
  end

  def set_total_price
    self.total_price = order_has_items.sum('quantity * price')
  end

  def set_credit_left
    credit_left = credit - courses.not_removed.count
    update_columns(credit_left: credit_left)
  end

  def set_credit
    if packs.present? && credit == 0
      pack_credits = packs.last.nb_of_courses
      update_columns(credit_left: pack_credits, credit: pack_credits)
    end
  end

  accepts_nested_attributes_for :order_has_items

  def item
    order_has_items.last.item if order_has_items.present?
  end
end
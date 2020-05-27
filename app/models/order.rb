class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :order_has_items
  has_many :courses
  has_many :programs, through: :order_has_items, source: :item, source_type: 'Program'
  has_many :packs, through: :order_has_items, source: :item, source_type: 'Pack'
  enum status: { waiting: 0, paid: 1, failed: 2, refunded: 3 }

  accepts_nested_attributes_for :order_has_items

  def item
    order_has_items.last.item
  end
end

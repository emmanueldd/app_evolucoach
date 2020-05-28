class OrderHasItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, polymorphic: true
  belongs_to :user, optional: true
  belongs_to :client, optional: true
  before_save :set_fields

  def set_fields
    # user and clients has many order_has_item through orders
    # self.user = item.user
    # self.client = order.client if order.present?
    self.price = item.price * 100
  end

end

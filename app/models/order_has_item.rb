class OrderHasItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, polymorphic: true
  belongs_to :user, optional: true
  belongs_to :client, optional: true
  before_save :set_fields
  after_save :set_order_credit

  def set_fields
    # user and clients has many order_has_item through orders
    # self.user = item.user
    # self.client = order.client if order.present?
    self.price = item.price

  end

  def set_order_credit
    # TODO : Prévoir plusieurs achats dans un panier
    if item_type == 'Pack' && order.credit == 0
      pack_credits = item.nb_of_courses
      order.update_columns(credit_left: pack_credits, credit: pack_credits)
    end
  end

end

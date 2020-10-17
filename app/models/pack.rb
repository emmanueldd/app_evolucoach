class Pack < ApplicationRecord
  belongs_to :user
  before_save :set_price, if: -> { unit_price_changed? }
  default_scope { order(nb_of_courses: :desc) }
  # Pack type à passer en integer pour activer les enums
  scope :published, -> { where(published: true) }
  enum pack_type: { solo: 0, duo: 1 }
  accepts_nested_attributes_for :user



  def set_price
    if unit_price.present? && nb_of_courses.present?
      self.price = unit_price * nb_of_courses
    end
  end
end

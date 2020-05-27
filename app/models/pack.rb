class Pack < ApplicationRecord
  belongs_to :user
  before_save :set_total_price, if: -> { unit_price_changed? }
  default_scope { order(nb_of_courses: :desc) }
  # Pack type à passer en integer pour activer les enums
  scope :published, -> { where(published: true) }
  scope :solo, -> { where(pack_type: 'solo') }
  scope :duo, -> { where(pack_type: 'duo') }
  enum pack_type: { solo: 0, duo: 1 }



  def set_total_price
    if unit_price.present? && nb_of_courses.present?
      self.total_price = unit_price * nb_of_courses
    end
  end
end

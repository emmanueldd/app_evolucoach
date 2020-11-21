class Exercise < ApplicationRecord
  belongs_to :exercise_category
  scope :published, -> { where(published: true).order(name: :asc) }
  before_save :set_name

  def set_name
    self.name = name.capitalize if name.present?
  end
end

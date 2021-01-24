module PriceSetting
  extend ActiveSupport::Concern
  attr_accessor :price_str
  def self.included(base)
    base.class_eval do
      before_save :set_price
    end
  end

  def set_price
    self.name = test if test.present?
  end

  # module ClassMethods
  #   before_save :set_name
  #   def set_name
  #     self.name = test if test.present?
  #   end
  # end
end

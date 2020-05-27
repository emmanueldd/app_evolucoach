class AddOrderIdToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :order, foreign_key: true
  end
end

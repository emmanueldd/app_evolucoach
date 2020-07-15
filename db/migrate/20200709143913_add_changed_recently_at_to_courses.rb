class AddChangedRecentlyAtToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :changed_recently_at, :datetime
  end
end

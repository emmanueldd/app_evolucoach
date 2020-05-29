class AddCourseInfosToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :course_infos, :string
  end
end

class ChangePublishedToDefaultFalseToPrograms < ActiveRecord::Migration[5.1]
  def up
    change_column_default :programs, :published, false
  end

  def down
    change_column_default :programs, :published, true
  end
end

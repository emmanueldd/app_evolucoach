class AddNotesToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :rest_note, :text
    add_column :programs, :info_note, :text
  end
end

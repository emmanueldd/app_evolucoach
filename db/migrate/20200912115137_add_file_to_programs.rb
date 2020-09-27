class AddFileToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :file, :string
  end
end

class AddCoverToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :cover, :string
  end
end

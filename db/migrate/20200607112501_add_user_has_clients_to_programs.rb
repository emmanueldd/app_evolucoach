class AddUserHasClientsToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_reference :programs, :user_has_client, foreign_key: true
  end
end

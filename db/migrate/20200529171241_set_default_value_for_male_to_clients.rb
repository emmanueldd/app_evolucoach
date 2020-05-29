class SetDefaultValueForMaleToClients < ActiveRecord::Migration[5.1]
  def up
    change_column_default :clients, :male, false
  end

  def down
    change_column_default :clients, :male, nil
  end
end

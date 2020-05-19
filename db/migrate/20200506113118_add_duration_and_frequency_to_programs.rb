class AddDurationAndFrequencyToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :duration, :integer
    add_column :programs, :frequency, :integer
  end
end

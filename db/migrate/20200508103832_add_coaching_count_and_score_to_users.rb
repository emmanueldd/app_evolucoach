class AddCoachingCountAndScoreToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :coaching_count, :integer, default: 0
    add_column :users, :score, :float, default: 5
  end
end

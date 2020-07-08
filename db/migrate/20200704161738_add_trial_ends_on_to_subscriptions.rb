class AddTrialEndsOnToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :trial_ends_on, :datetime
  end
end

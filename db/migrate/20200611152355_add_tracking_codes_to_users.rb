class AddTrackingCodesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ga_code, :text
    add_column :users, :fb_pixel_code, :text
  end
end

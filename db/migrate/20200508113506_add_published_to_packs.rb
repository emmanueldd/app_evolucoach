class AddPublishedToPacks < ActiveRecord::Migration[5.1]
  def change
    add_column :packs, :published, :boolean, default: false
  end
end

class RemoveLatestArtworkUrlColumnFromOrder < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :latest_artwork_url, :text
  end
end

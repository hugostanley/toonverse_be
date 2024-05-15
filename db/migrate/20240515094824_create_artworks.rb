class CreateArtworks < ActiveRecord::Migration[7.1]
  def change
    create_table :artworks do |t|
      t.references :order, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.string :artwork_url
      t.integer :revision_number

      t.timestamps
    end
  end
end

class CreateArtworks < ActiveRecord::Migration[7.1]
  def change
    create_table :artworks do |t|
      t.belongs_to :job, null: false, foreign_key: true
      t.belongs_to :workforce, null: false, foreign_key: true
      t.integer :revision_number, default: 0, null: false
      t.string :artwork_url

      t.timestamps
    end
  end
end

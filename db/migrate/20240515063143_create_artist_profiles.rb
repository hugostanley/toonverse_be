class CreateArtistProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :artist_profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :bio, limit: 120
      t.string :billing_address, null: false
      t.string :mobile_number
      t.decimal :total_earnings, default: 0.00, precision: 15, scale: 2
      t.belongs_to :workforce, null: false, foreign_key: true

      t.timestamps
    end
  end
end

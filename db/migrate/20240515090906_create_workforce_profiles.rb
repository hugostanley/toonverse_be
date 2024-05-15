class CreateWorkforceProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :workforce_profiles do |t|
      t.references :workforce, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :bio
      t.decimal :total_earnings

      t.timestamps
    end
  end
end

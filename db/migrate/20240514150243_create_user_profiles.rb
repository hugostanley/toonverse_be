class CreateUserProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :billing_address, null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

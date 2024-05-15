class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.decimal :total_amount
      t.integer :status
      t.string :remarks

      t.timestamps
    end
  end
end

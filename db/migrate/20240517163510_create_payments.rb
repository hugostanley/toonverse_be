class CreatePayments < ActiveRecord::Migration[7.1]

  create_enum "status", ["pending", "paid", "cancelled", "refunded"]

  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.decimal :item_amount, null: false, default: 0.00, precision: 15, scale: 2
      t.enum :status, enum_type: 'status',null: false, default: 'pending'
      t.string :remarks

      t.timestamps
    end
  end
end

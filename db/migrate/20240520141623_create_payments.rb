class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_enum :payment_status, %w[awaiting_payment_method paid cancelled]

    create_table :payments do |t|
      t.integer :item_ids, array: true, default: []
      t.decimal :total_amount, precision: 10, scale: 2
      t.enum :payment_status, enum_type: 'payment_status', null: false, default: 'awaiting_payment_method'
      t.text :checkout_session_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :payments, :item_ids
  end
end

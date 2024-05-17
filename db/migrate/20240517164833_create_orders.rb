class CreateOrders < ActiveRecord::Migration[7.1]

  def change

    create_enum 'order_status', ['in_queued', 'in_progress', 'delivered', 'completed', 'cancelled']

    create_table :orders do |t|
      t.references :payment, null: false, foreign_key: true
      t.decimal :amount, null: false, default: 0.00, precision: 15, scale: 2
      t.string :remarks
      t.string :latest_artwork_url, null: false
      t.enum :status, null: false, enum_type: 'order_status', default: 'in_queued'

      t.timestamps
    end
  end
end

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_enum :order_status, %w[queued in_progress delivered completed cancelled]

    create_table :orders do |t|
      t.references :payment, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.text :remarks
      t.text :latest_artwork_url
      t.enum :order_status, enum_type: 'order_status', null: false, default: 'queued'

      t.timestamps
    end
  end
end

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :payment, null: false, foreign_key: true
      t.decimal :amount
      t.string :remarks
      t.string :latest_artwork_url
      t.integer :status

      t.timestamps
    end
  end
end

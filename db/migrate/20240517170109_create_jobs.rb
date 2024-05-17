class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.references :workforce, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.datetime :claimed_at, null: false
      t.decimal :commision, null: false, default: 0.00, precision: 15, scale: 2
      t.decimal :total_paid, null: false, default: 0.00, precision: 15, scale: 2

      t.timestamps
    end
  end
end

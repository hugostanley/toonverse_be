class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.references :workforce, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.datetime :claimed_at
      t.decimal :commision
      t.decimal :total_paid

      t.timestamps
    end
  end
end

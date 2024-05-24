class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.datetime :claimed_at
      t.decimal :commission, null: false

      t.timestamps
    end
  end
end

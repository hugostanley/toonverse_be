class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :background_url
      t.integer :number_of_heads
      t.integer :picture_style
      t.string :notes
      t.string :ref_photo_url

      t.timestamps
    end
  end
end

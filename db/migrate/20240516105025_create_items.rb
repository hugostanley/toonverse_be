class CreateItems < ActiveRecord::Migration[7.1]
  def change

    create_enum :picture_style, ['vector', 'bobs burger', 'rick and morty']

    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :background_url, null: false
      t.integer :number_of_heads, null: false, default: 0
      t.enum :picture_style, enum_type: 'picture_style', null: false
      t.string :notes
      t.string :ref_photo_url, null: false
      t.decimal :amount, default: 0.00, precision: 15, scale: 2

      t.timestamps
    end
  end
end

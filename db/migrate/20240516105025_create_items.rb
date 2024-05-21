class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_enum 'art_style', %w[bobs_burger rick_and_morty vector]
    create_enum 'picture_style', %w[full_body half_body shoulders_up]

    create_table :items do |t|
      t.references :user, null: false, foreign_key: true

      t.references :payment
      t.string :background_url, null: false
      t.integer :number_of_heads, null: false, default: 0
      t.enum :picture_style, enum_type: 'picture_style', null: false
      t.enum :art_style, enum_type: 'art_style', null: false
      t.string :notes
      t.decimal :amount, default: 0.00, precision: 15, scale: 2

      t.timestamps
    end
  end
end

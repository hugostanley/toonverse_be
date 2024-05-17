class DropAndRecreateItemsTableAndEnums < ActiveRecord::Migration[7.1]
  def change
    # Step 1: Drop the items table
    drop_table :items, if_exists: true

    # Step 2: Drop the enums
    execute <<-SQL
      DROP TYPE IF EXISTS art_style;
      DROP TYPE IF EXISTS new_picture_style;
      DROP TYPE IF EXISTS picture_style;
    SQL

    # Step 3: Recreate the enums
    execute <<-SQL
      CREATE TYPE art_style AS ENUM ('bobs_burger', 'rick_and_morty', 'vector');
      CREATE TYPE picture_style AS ENUM ('full_body', 'half_body', 'shoulders_up');
    SQL

    # Step 4: Recreate the items table
    create_table :items do |t|
      t.bigint :user_id, null: false
      t.string :background_url, null: false
      t.integer :number_of_heads, default: 0, null: false
      t.enum :picture_style, null: false, enum_type: "picture_style"
      t.enum :art_style, null: false, enum_type: "art_style"
      t.string :notes
      t.string :ref_photo_url, null: false
      t.decimal :amount, precision: 15, scale: 2, default: "0.0"
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index :user_id, name: "index_items_on_user_id"
    end
  end
end

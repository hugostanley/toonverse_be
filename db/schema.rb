# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_20_141623) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "art_style", ["bobs_burger", "rick_and_morty", "vector"]
  create_enum "payment_status", ["awaiting_payment_method", "paid", "cancelled"]
  create_enum "picture_style", ["full_body", "half_body", "shoulders_up"]
  create_enum "role", ["admin", "artist"]

  create_table "artist_profiles", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "bio"
    t.string "billing_address", null: false
    t.string "mobile_number"
    t.decimal "total_earnings", precision: 15, scale: 2, default: "0.0"
    t.bigint "workforce_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workforce_id"], name: "index_artist_profiles_on_workforce_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "payment_id"
    t.string "background_url", null: false
    t.integer "number_of_heads", default: 0, null: false
    t.enum "picture_style", null: false, enum_type: "picture_style"
    t.enum "art_style", null: false, enum_type: "art_style"
    t.string "notes"
    t.decimal "amount", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_items_on_payment_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "item_ids", default: [], array: true
    t.decimal "total_amount", precision: 10, scale: 2
    t.enum "payment_status", default: "awaiting_payment_method", null: false, enum_type: "payment_status"
    t.text "checkout_session_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_ids"], name: "index_payments_on_item_ids"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "billing_address", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "workforces", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.enum "role", default: "artist", null: false, enum_type: "role"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_workforces_on_confirmation_token", unique: true
    t.index ["email"], name: "index_workforces_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workforces_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_workforces_on_uid_and_provider", unique: true
  end

  add_foreign_key "artist_profiles", "workforces"
  add_foreign_key "items", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "user_profiles", "users"
end

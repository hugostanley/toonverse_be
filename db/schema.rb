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

ActiveRecord::Schema[7.1].define(version: 2024_05_15_094824) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artworks", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "job_id", null: false
    t.string "artwork_url"
    t.integer "revision_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_artworks_on_job_id"
    t.index ["order_id"], name: "index_artworks_on_order_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "background_url"
    t.integer "number_of_heads"
    t.integer "picture_style"
    t.string "notes"
    t.string "ref_photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "workforce_id", null: false
    t.bigint "order_id", null: false
    t.datetime "claimed_at"
    t.decimal "commision"
    t.decimal "total_paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_jobs_on_order_id"
    t.index ["workforce_id"], name: "index_jobs_on_workforce_id"
  end

  create_table "order_specifications", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "background_url"
    t.integer "number_of_heads"
    t.integer "picture_style"
    t.string "notes"
    t.string "ref_photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_specifications_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "payment_id", null: false
    t.decimal "amount"
    t.string "remarks"
    t.string "latest_artwork_url"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_orders_on_payment_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.decimal "total_amount"
    t.integer "status"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_payments_on_item_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "billing_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workforce_profiles", force: :cascade do |t|
    t.bigint "workforce_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "bio"
    t.decimal "total_earnings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workforce_id"], name: "index_workforce_profiles_on_workforce_id"
  end

  create_table "workforces", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_workforces_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workforces_on_reset_password_token", unique: true
  end

  add_foreign_key "artworks", "jobs"
  add_foreign_key "artworks", "orders"
  add_foreign_key "items", "users"
  add_foreign_key "jobs", "orders"
  add_foreign_key "jobs", "workforces"
  add_foreign_key "order_specifications", "orders"
  add_foreign_key "orders", "payments"
  add_foreign_key "payments", "items"
  add_foreign_key "payments", "users"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "workforce_profiles", "workforces"
end

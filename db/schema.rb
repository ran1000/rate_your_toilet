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

ActiveRecord::Schema[7.0].define(version: 2022_05_30_160108) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "toilet_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["toilet_id"], name: "index_favorites_on_toilet_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.integer "rating"
    t.boolean "baby"
    t.boolean "accessible"
    t.boolean "sink"
    t.boolean "soap"
    t.boolean "paper"
    t.boolean "tampon"
    t.boolean "bin"
    t.boolean "hanger"
    t.boolean "spacious"
    t.boolean "clean"
    t.boolean "gendered"
    t.boolean "privacy"
    t.boolean "urinal"
    t.boolean "towel"
    t.boolean "gratis"
    t.bigint "toilet_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["toilet_id"], name: "index_reviews_on_toilet_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "toilets", force: :cascade do |t|
    t.string "address"
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_toilets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "favorites", "toilets"
  add_foreign_key "favorites", "users"
  add_foreign_key "reviews", "toilets"
  add_foreign_key "reviews", "users"
  add_foreign_key "toilets", "users"
end

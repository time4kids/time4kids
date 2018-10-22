# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_22_151218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "country", null: false
    t.string "region"
    t.string "city", null: false
    t.string "street", null: false
    t.string "number"
    t.string "postal_code"
    t.float "lat"
    t.float "long"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "school_categories", id: false, force: :cascade do |t|
    t.bigint "school_profile_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id", "school_profile_id"], name: "category_index"
    t.index ["school_profile_id", "category_id"], name: "school_profile_index"
  end

  create_table "school_profiles", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.string "website"
    t.text "description", null: false
    t.bigint "address_id"
    t.index ["address_id"], name: "index_school_profiles_on_address_id"
  end

  create_table "student_profiles", force: :cascade do |t|
    t.string "phone"
    t.bigint "address_id"
    t.integer "age"
    t.string "gender"
    t.index ["address_id"], name: "index_student_profiles_on_address_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "is_active", default: true
    t.string "profile_type"
    t.bigint "profile_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_type", "profile_id"], name: "index_users_on_profile_type_and_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "school_profiles", "addresses"
  add_foreign_key "student_profiles", "addresses"
end

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

ActiveRecord::Schema[8.1].define(version: 2026_04_13_130405) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "occupations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", comment: "職業名"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_occupations_on_name", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.date "birthday", null: false, comment: "生年月日"
    t.datetime "created_at", null: false
    t.integer "gender", null: false, comment: "性別(1:男, 2:女, 3その他"
    t.text "introduction", comment: "自己紹介"
    t.string "name", null: false, comment: "アカウント名"
    t.bigint "occupation_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["occupation_id"], name: "index_profiles_on_occupation_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "programming_languages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", comment: "言語名"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_programming_languages_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false, comment: "メールアドレス"
    t.string "password_digest", null: false, comment: "パスワード"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "profiles", "occupations"
  add_foreign_key "profiles", "users"
end

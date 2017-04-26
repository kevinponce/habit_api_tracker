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

ActiveRecord::Schema.define(version: 20170424145135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "habit_records", force: :cascade do |t|
    t.string   "tz"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "habit_id"
    t.index ["habit_id"], name: "index_habit_records_on_habit_id", using: :btree
  end

  create_table "habits", force: :cascade do |t|
    t.string   "title"
    t.string   "color"
    t.text     "question"
    t.string   "tz"
    t.datetime "remind_at"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.boolean  "deleted",    default: false
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_habits_on_user_id", using: :btree
  end

  create_table "kp_jwt_tokens", force: :cascade do |t|
    t.string   "hashed_token"
    t.string   "token_type"
    t.string   "entity"
    t.integer  "entity_id"
    t.datetime "exp"
    t.boolean  "revoked",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["hashed_token"], name: "index_kp_jwt_tokens_on_hashed_token", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

end

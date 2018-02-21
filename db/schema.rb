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

ActiveRecord::Schema.define(version: 20180201190408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "relationals", force: :cascade do |t|
    t.integer "parent_id", null: false
    t.integer "children_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["children_id"], name: "index_relationals_on_children_id", unique: true
    t.index ["parent_id", "children_id"], name: "index_relationals_on_parent_id_and_children_id", unique: true
    t.index ["parent_id"], name: "index_relationals_on_parent_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_id"
    t.text "title"
    t.text "content"
    t.time "time_required"
    t.integer "level"
    t.datetime "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "descendant"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.text "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

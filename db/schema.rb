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

ActiveRecord::Schema.define(version: 20180502054936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "project_id", null: false
    t.bigint "column_id", null: false
    t.date "due_date"
    t.integer "assignee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_cards_on_column_id"
    t.index ["name", "project_id"], name: "index_cards_on_name_and_project_id", unique: true
    t.index ["project_id"], name: "index_cards_on_project_id"
  end

  create_table "column_positions", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "column_id", null: false
    t.integer "sequence_num", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_column_positions_on_column_id"
    t.index ["project_id"], name: "index_column_positions_on_project_id"
  end

  create_table "columns", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "project_id"], name: "index_columns_on_name_and_project_id", unique: true
    t.index ["project_id"], name: "index_columns_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "uid", null: false
    t.string "provider"
    t.string "sns_image"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "cards", "columns"
  add_foreign_key "cards", "projects"
  add_foreign_key "column_positions", "columns"
  add_foreign_key "column_positions", "projects"
  add_foreign_key "columns", "projects"
end

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

ActiveRecord::Schema.define(version: 20170328225145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjectives", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_adjectives_on_name", using: :btree
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "assignee_id"
    t.integer  "assigned_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "completed?",  default: false
  end

  create_table "descriptions", force: :cascade do |t|
    t.integer  "describer_id"
    t.integer  "describee_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "adjective_id"
    t.index ["adjective_id"], name: "index_descriptions_on_adjective_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assignments", "users", column: "assigned_id"
  add_foreign_key "assignments", "users", column: "assignee_id"
  add_foreign_key "descriptions", "adjectives"
  add_foreign_key "descriptions", "users", column: "describee_id"
  add_foreign_key "descriptions", "users", column: "describer_id"
end

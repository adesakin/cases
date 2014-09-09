# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140907160753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flows", force: true do |t|
    t.integer  "step_id"
    t.integer  "slice_id"
    t.integer  "sort_order"
    t.string   "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.string   "title"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "pieces", force: true do |t|
    t.string   "name"
    t.string   "doc"
    t.integer  "modified_by_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "documentable_id"
    t.string   "documentable_type"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slices", force: true do |t|
    t.integer  "priority"
    t.string   "workflow_state"
    t.string   "estimate"
    t.integer  "release_id"
    t.integer  "order_priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "steps", force: true do |t|
    t.string   "custom_id"
    t.string   "state"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "use_case_id"
    t.string   "type"
  end

  create_table "use_cases", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "pre_condition"
    t.text     "standard_flow"
    t.text     "alternate_flow"
    t.text     "post_condition"
    t.text     "open_issue"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.string   "doc"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

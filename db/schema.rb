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

ActiveRecord::Schema.define(version: 20141017052312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lookups", force: true do |t|
    t.string   "lookup_type"
    t.string   "name"
    t.string   "name_display"
    t.float    "name_display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models_OLD", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models_OLD", ["email"], name: "index_models_on_email", unique: true, using: :btree
  add_index "models_OLD", ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true, using: :btree

  create_table "node_attribute_floatvalues", force: true do |t|
    t.string   "value_float"
    t.string   "nodes_id"
    t.string   "node_attributes_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_attribute_integervalues", force: true do |t|
    t.integer  "value_integer"
    t.string   "nodes_id"
    t.string   "node_attributes_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_attribute_stringvalues", force: true do |t|
    t.string   "value_string"
    t.string   "nodes_id"
    t.string   "node_attributes_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_attributes", force: true do |t|
    t.integer  "node_attribute_type_id"
    t.string   "name"
    t.string   "name_display"
    t.float    "name_display_order"
    t.integer  "node_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_nodes", force: true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.integer  "node_depth_type"
    t.boolean  "non_unique"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.string   "name_display"
    t.string   "node_type_id_OLD"
    t.integer  "user_id"                #changed SSSSSSS
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "node_type_id"
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

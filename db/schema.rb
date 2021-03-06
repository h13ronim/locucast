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

ActiveRecord::Schema.define(version: 20151108191343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "uploaded_files", force: :cascade do |t|
    t.integer  "upload_id",  null: false
    t.string   "url",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "author"
    t.string   "guid"
    t.float    "duration"
    t.integer  "length"
    t.datetime "deleted_at"
  end

  add_index "uploaded_files", ["deleted_at"], name: "index_uploaded_files_on_deleted_at", using: :btree
  add_index "uploaded_files", ["upload_id"], name: "index_uploaded_files_on_upload_id", using: :btree

  create_table "uploads", force: :cascade do |t|
    t.integer  "user_id",                                      null: false
    t.string   "name",                                         null: false
    t.string   "description"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "uploaded_files_order",            default: [],              array: true
    t.string   "author"
    t.string   "token",                limit: 64
    t.datetime "deleted_at"
    t.string   "picture_url"
  end

  add_index "uploads", ["deleted_at"], name: "index_uploads_on_deleted_at", using: :btree
  add_index "uploads", ["user_id"], name: "index_uploads_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "provider"
    t.string   "uid"
    t.datetime "deleted_at"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "uploaded_files", "uploads"
  add_foreign_key "uploads", "users"
end

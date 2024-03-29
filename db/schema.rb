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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111107201308) do

  create_table "gal_albums", :force => true do |t|
    t.integer  "gal_category_id"
    t.string   "name",            :limit => 50,                :null => false
    t.string   "description"
    t.string   "permalink",       :limit => 50,                :null => false
    t.integer  "status",                        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gal_albums", ["name"], :name => "index_gal_albums_on_name", :unique => true
  add_index "gal_albums", ["permalink"], :name => "index_gal_albums_on_permalink", :unique => true

  create_table "gal_categories", :force => true do |t|
    t.string   "name",        :limit => 50,                :null => false
    t.string   "description"
    t.string   "permalink",   :limit => 50,                :null => false
    t.integer  "status",                    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gal_categories", ["name"], :name => "index_gal_categories_on_name", :unique => true
  add_index "gal_categories", ["permalink"], :name => "index_gal_categories_on_permalink", :unique => true

  create_table "users", :force => true do |t|
    t.string   "nick",               :limit => 16
    t.string   "name"
    t.string   "email",              :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["nick"], :name => "index_users_on_nick", :unique => true

end

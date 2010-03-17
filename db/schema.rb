# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100320162340) do

  create_table "addresses", :force => true do |t|
    t.string  "street"
    t.string  "state"
    t.integer "city_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "create_tableeated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
  end

  add_index "cities", ["name", "country_id"], :name => "index_cities_on_name_and_country_id", :unique => true

  create_table "countries", :force => true do |t|
    t.string "name"
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "picture_url"
    t.integer  "taken_by"
    t.boolean  "accepted"
    t.integer  "person_id"
    t.integer  "address_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "newsletters", :force => true do |t|
    t.string   "mail"
    t.datetime "created_at"
    t.string   "name"
  end

  create_table "people", :force => true do |t|
    t.string   "username",       :limit => 40
    t.string   "email",          :limit => 100
    t.text     "biography"
    t.integer  "address_id"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed_user",                :default => false
    t.string   "first_name",     :limit => 20,  :default => ""
    t.string   "last_name",      :limit => 20,  :default => ""
    t.boolean  "admin"
    t.string   "login_token",                 :limit => 40
    t.datetime "login_token_expires_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "requester_id"
    t.integer  "item_id"
    t.boolean  "accepted", :default => false
    t.datetime "created_at"
  end
  
  create_table "messages", :force => true do |t|
    t.datetime "created_at"
    t.string   "title"
    t.text     "text"
    t.boolean  "read",        :default => 0
    t.integer  "recipient_id"
    t.integer  "author_id"
    t.integer  "request_id"
    t.datetime "replied_at"
    t.integer  "reply_id"
  end

  create_table "states", :force => true do |t|
    t.string  "name"
    t.integer "country_id"
  end
  
end

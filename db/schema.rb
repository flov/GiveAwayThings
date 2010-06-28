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

ActiveRecord::Schema.define(:version => 20100622172839) do
  
  create_table "addresses", :force => true do |t|
    t.string  "continent"
    t.string  "country"
    t.string  "city"
    t.string  "street"
    t.string  "state"
    t.float   "lng"
    t.float   "lat"
  end
  
  add_index "addresses", ["country"], :name => "index_country"
  add_index "addresses", ["city"],    :name => "index_city"
  add_index "addresses", ["street"],  :name => "index_street"

  create_table "items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "picture_url"
    t.integer  "taken_by", :default => nil
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
    t.text     "first_name"
    t.text     "last_name"
    t.integer  "address_id"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed_user",                :default => false
    t.boolean  "admin"
    t.string   "login_token",                 :limit => 40
    t.datetime "login_token_expires_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "requester_id"
    t.integer  "item_id"
    t.boolean  "accepted", :default => false
    t.boolean  "archived", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
  create_table "messages", :force => true do |t|
    t.datetime "created_at"
    t.string   "title"
    t.text     "text"
    t.boolean  "read",        :default => false
    t.integer  "recipient_id"
    t.integer  "author_id"
    t.integer  "request_id"
    t.datetime "replied_at"
    t.integer  "reply_id"
  end
  
  create_table "references", :force => true do |t|
    t.integer  "rating_id"
    t.text     "text"
    t.integer  "item_id"
    t.integer  "from_id"
    t.integer  "to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string  "name"
    t.integer "country_id"
  end

  create_table "app_links", :force => true do |t|
    t.integer  "person_id"
    t.string   "provider"
    t.string   "app_user_id"
    t.text     "custom_attributes"
    t.datetime "created_at"
  end  
end


ActiveRecord::Schema.define(:version => 20100122153004) do

  create_table :addresses, :force => true do |t|
    t.string :street
    t.string :state
    t.integer :city_id
  end

  create_table :cities, :force => true do |t|
    t.string :name
    t.integer :country_id
  end

  add_index :cities, [:name, :country_id], :unique => true

  create_table :countries, :force => true do |t|
    t.string :name
    t.string :iso
  end

  create_table :categories, :force => true do |t|
    t.string   :name
  end

  create_table :requests, :force => true do |t|
    t.integer   :person_id
    t.integer   :item_id
    t.text      :text
    t.boolean   :accepted
    t.datetime  :created_at
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "picture_url"
    t.integer  "taken_by"
    t.integer  "person_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "username"
    t.string   "email",          :limit => 100
    t.integer  :address_id
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed_user",                :default => false
    t.string   "gender",                        :default => "male"
    t.string   "first_name",     :limit => 20,  :default => ""
    t.string   "last_name",      :limit => 20,  :default => ""
  end

end

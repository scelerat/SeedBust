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

ActiveRecord::Schema.define(:version => 20100530005208) do

  create_table "plants", :force => true do |t|
    t.integer  "parent_plant_id"
    t.integer  "planted_user_id"
    t.integer  "origin_user_id"
    t.string   "name"
    t.string   "state"
    t.integer  "plant_id"
    t.date     "date_planted"
    t.integer  "lat",             :default => 0
    t.integer  "lon",             :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "species", :force => true do |t|
    t.string   "name"
    t.string   "image",         :default => "default.png"
    t.integer  "growth_factor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "fb_id"
    t.string   "fb_first_name"
    t.string   "fb_last_name"
    t.string   "fb_link"
    t.integer  "fb_last_lat"
    t.integer  "fb_last_lon"
    t.string   "role",          :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
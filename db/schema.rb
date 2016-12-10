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

ActiveRecord::Schema.define(version: 20161113210312) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "neighborhood"
    t.string   "house_no"
    t.string   "street"
    t.string   "apt_no"
    t.string   "city"
    t.string   "state"
    t.boolean  "hide_map",                     default: false
    t.integer  "zip"
    t.date     "call_date"
    t.integer  "territory_id"
    t.integer  "client_id"
    t.string   "center_coordinate"
    t.float    "latitude",          limit: 24
    t.float    "longitude",         limit: 24
    t.string   "alt_house_no"
    t.string   "alt_street"
    t.string   "alt_city"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "country_id"
    t.float    "latitude",           limit: 24
    t.float    "longitude",          limit: 24
    t.string   "language"
    t.string   "center_coordinate"
    t.boolean  "is_coordinate_only",            default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "coordinates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "territory_id"
    t.integer  "zone_id"
    t.string   "coordinate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "code"
    t.string   "region"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.float    "latitude",          limit: 24
    t.float    "longitude",         limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "householders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "fname"
    t.string   "lname"
    t.text     "notes",      limit: 65535
    t.text     "phone",      limit: 65535
    t.integer  "address_id"
    t.date     "call_date"
    t.integer  "client_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "map_layers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "layer_url"
    t.string   "provider"
    t.text     "api_key",    limit: 65535
    t.integer  "max_zoom"
    t.integer  "min_zoom"
    t.boolean  "is_mapbox",                default: false
    t.string   "map_type"
    t.string   "file_ext"
    t.string   "subdomains"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "territories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "territory_no"
    t.text     "description",       limit: 65535
    t.text     "notes",             limit: 65535
    t.integer  "zone_id"
    t.date     "last_worked"
    t.date     "checkout_date"
    t.date     "checkin_date"
    t.integer  "user_id"
    t.date     "check_back_in"
    t.string   "view_key"
    t.boolean  "is_checked_in",                   default: true
    t.integer  "client_id"
    t.boolean  "is_dynamic"
    t.string   "center_coordinate"
    t.integer  "zoom"
    t.boolean  "fill_color"
    t.string   "border_color"
    t.integer  "border_size"
    t.integer  "map_layer_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "territory_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "territory_id"
    t.date     "check_out_date"
    t.date     "check_in_date"
    t.string   "user_id"
    t.integer  "client_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "password"
    t.integer  "client_id"
    t.string   "email"
    t.string   "fname"
    t.string   "lname"
    t.boolean  "isadmin"
    t.boolean  "must_change_pass", default: false
    t.boolean  "can_manage_hh"
    t.string   "mappref"
    t.date     "lastlogin"
    t.string   "sitelang"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "warning_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "msg_name"
    t.boolean  "hide"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "zone_no"
    t.text     "description",       limit: 65535
    t.integer  "client_id"
    t.string   "center_coordinate"
    t.integer  "zoom"
    t.string   "city"
    t.string   "state"
    t.integer  "country_id"
    t.boolean  "fill_color"
    t.string   "border_color"
    t.integer  "border_size"
    t.integer  "map_layer_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end

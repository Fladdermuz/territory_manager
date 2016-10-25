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

ActiveRecord::Schema.define(version: 20160417045926) do

  create_table "addresses", force: :cascade do |t|
    t.string   "neighborhood",    limit: 255
    t.string   "house_no",        limit: 255
    t.string   "street",          limit: 255
    t.string   "apt_no",          limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.boolean  "hide_map",                    default: false
    t.integer  "zip",             limit: 4
    t.date     "call_date"
    t.integer  "territory_id",    limit: 4
    t.integer  "congregation_id", limit: 4
    t.string   "coordinate",      limit: 255
    t.string   "alt_house_no",    limit: 255
    t.string   "alt_street",      limit: 255
    t.string   "alt_city",        limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "congregations", force: :cascade do |t|
    t.string   "congname",                limit: 255
    t.string   "address",                 limit: 255
    t.string   "city",                    limit: 255
    t.string   "state",                   limit: 255
    t.string   "zip",                     limit: 255
    t.string   "country",                 limit: 255
    t.string   "language",                limit: 255
    t.integer  "contact_id",              limit: 4
    t.boolean  "disable_terr_maps",                   default: false
    t.boolean  "disable_all_google_maps",             default: false
    t.boolean  "is_coordinate_only",                  default: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  create_table "coordinates", force: :cascade do |t|
    t.integer  "territory_id", limit: 4
    t.string   "coordinate",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "householders", force: :cascade do |t|
    t.string   "fname",           limit: 255
    t.string   "lname",           limit: 255
    t.text     "notes",           limit: 65535
    t.text     "phone",           limit: 65535
    t.integer  "address_id",      limit: 4
    t.date     "call_date"
    t.integer  "congregation_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "map_layers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "layer_url",  limit: 255
    t.string   "provider",   limit: 255
    t.text     "api_key",    limit: 65535
    t.integer  "max_zoom",   limit: 4
    t.integer  "min_zoom",   limit: 4
    t.boolean  "is_mapbox",                default: false
    t.string   "map_type",   limit: 255
    t.string   "file_ext",   limit: 255
    t.string   "subdomains", limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "territories", force: :cascade do |t|
    t.string   "territory_no",       limit: 255
    t.text     "descrip",            limit: 65535
    t.text     "notes",              limit: 65535
    t.string   "img_url",            limit: 255
    t.integer  "zone_id",            limit: 4
    t.date     "last_worked"
    t.date     "checkout_date"
    t.text     "checked_out_by",     limit: 65535
    t.boolean  "is_checked_in",                    default: true
    t.integer  "congregation_id",    limit: 4
    t.boolean  "is_dynamic"
    t.string   "center_coordinate",  limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "zoom",               limit: 4
    t.string   "color",              limit: 255
    t.string   "border_color",       limit: 255
    t.string   "maptype",            limit: 255
    t.boolean  "isreserved",                       default: false
    t.string   "reserved_by",        limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "territory_histories", force: :cascade do |t|
    t.integer  "territory_id",    limit: 4
    t.date     "check_out_date"
    t.date     "check_in_date"
    t.string   "checked_out_by",  limit: 255
    t.integer  "congregation_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "password",        limit: 255
    t.integer  "congregation_id", limit: 4
    t.string   "email",           limit: 255
    t.string   "fname",           limit: 255
    t.string   "lname",           limit: 255
    t.boolean  "isadmin"
    t.boolean  "iscongadmin"
    t.string   "mappref",         limit: 255
    t.date     "lastlogin"
    t.string   "sitelang",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "zones", force: :cascade do |t|
    t.integer  "zone_no",         limit: 4
    t.text     "descrip",         limit: 65535
    t.string   "img_url",         limit: 255
    t.integer  "congregation_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end

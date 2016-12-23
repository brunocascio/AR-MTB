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

ActiveRecord::Schema.define(version: 20161120184955) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
  end

  create_table "categories_subcategories", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "category_id",    null: false
    t.integer "subcategory_id", null: false
    t.index ["category_id", "subcategory_id"], name: "index_categories_subcategories_on_category_id_and_subcategory_id", using: :btree
  end

  create_table "championships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",                      null: false
    t.integer  "year",                      null: false
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["name", "year"], name: "index_championships_on_name_and_year", unique: true, using: :btree
  end

  create_table "championships_participants", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "participant_id",  null: false
    t.integer "championship_id", null: false
    t.index ["participant_id", "championship_id"], name: "index_part_champ_on_part_id_and_champ_id", using: :btree
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_locations_on_name", unique: true, using: :btree
  end

  create_table "participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "firstname",             null: false
    t.string   "lastname",              null: false
    t.integer  "genre",                 null: false
    t.date     "birthdate",             null: false
    t.string   "identification_number", null: false
    t.integer  "identification_type",   null: false
    t.integer  "location_id",           null: false
    t.integer  "category_id",           null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["category_id"], name: "index_participants_on_category_id", using: :btree
    t.index ["firstname"], name: "index_participants_on_firstname", using: :btree
    t.index ["identification_number", "identification_type"], name: "id_number_and_type_index", unique: true, using: :btree
    t.index ["lastname"], name: "index_participants_on_lastname", using: :btree
    t.index ["location_id"], name: "index_participants_on_location_id", using: :btree
  end

  create_table "races", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "kms",         null: false
    t.integer  "lasts",       null: false
    t.integer  "category_id", null: false
    t.integer  "schedule_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_races_on_category_id", using: :btree
    t.index ["schedule_id"], name: "index_races_on_schedule_id", using: :btree
  end

  create_table "results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.time     "time",               null: false
    t.integer  "position",           null: false
    t.string   "participant_number", null: false
    t.integer  "participant_id",     null: false
    t.integer  "category_id",        null: false
    t.integer  "subcategory_id",     null: false
    t.integer  "race_id",            null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["category_id"], name: "index_results_on_category_id", using: :btree
    t.index ["participant_id", "race_id"], name: "index_results_on_participant_id_and_race_id", unique: true, using: :btree
    t.index ["participant_id"], name: "index_results_on_participant_id", using: :btree
    t.index ["race_id"], name: "index_results_on_race_id", using: :btree
    t.index ["subcategory_id"], name: "index_results_on_subcategory_id", using: :btree
  end

  create_table "schedules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "number",                        null: false
    t.date     "date",                          null: false
    t.time     "start_time"
    t.text     "description",     limit: 65535
    t.integer  "location_id",                   null: false
    t.integer  "championship_id",               null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["championship_id"], name: "index_schedules_on_championship_id", using: :btree
    t.index ["date"], name: "index_schedules_on_date", using: :btree
    t.index ["location_id"], name: "index_schedules_on_location_id", using: :btree
  end

  create_table "subcategories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",       null: false
    t.integer  "age_start",  null: false
    t.integer  "age_end",    null: false
    t.integer  "genre",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "genre"], name: "index_subcategories_on_name_and_genre", unique: true, using: :btree
  end

  add_foreign_key "participants", "categories"
  add_foreign_key "participants", "locations"
  add_foreign_key "results", "categories"
  add_foreign_key "results", "participants"
  add_foreign_key "results", "races"
  add_foreign_key "results", "subcategories"
end

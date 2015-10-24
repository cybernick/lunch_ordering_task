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

ActiveRecord::Schema.define(version: 20151023082105) do

  create_table "drinks", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drinks_menus", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "drink_id"
  end

  add_index "drinks_menus", ["drink_id"], name: "index_drinks_menus_on_drink_id"
  add_index "drinks_menus", ["menu_id"], name: "index_drinks_menus_on_menu_id"

  create_table "first_courses", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "first_courses_menus", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "first_course_id"
  end

  add_index "first_courses_menus", ["first_course_id"], name: "index_first_courses_menus_on_first_course_id"
  add_index "first_courses_menus", ["menu_id"], name: "index_first_courses_menus_on_menu_id"

  create_table "menus", force: :cascade do |t|
    t.date     "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus_second_courses", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "second_course_id"
  end

  add_index "menus_second_courses", ["menu_id"], name: "index_menus_second_courses_on_menu_id"
  add_index "menus_second_courses", ["second_course_id"], name: "index_menus_second_courses_on_second_course_id"

  create_table "orders", force: :cascade do |t|
    t.date     "day"
    t.integer  "user_id"
    t.integer  "first_course_id"
    t.integer  "second_course_id"
    t.integer  "drink_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "orders", ["drink_id"], name: "index_orders_on_drink_id"
  add_index "orders", ["first_course_id"], name: "index_orders_on_first_course_id"
  add_index "orders", ["second_course_id"], name: "index_orders_on_second_course_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "organizations", force: :cascade do |t|
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
    t.string   "name"
    t.string   "auth_token",             default: ""
  end

  add_index "organizations", ["auth_token"], name: "index_organizations_on_auth_token", unique: true
  add_index "organizations", ["email"], name: "index_organizations_on_email", unique: true
  add_index "organizations", ["reset_password_token"], name: "index_organizations_on_reset_password_token", unique: true

  create_table "second_courses", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "second_courses_menus", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "second_course_id"
  end

  add_index "second_courses_menus", ["menu_id"], name: "index_second_courses_menus_on_menu_id"
  add_index "second_courses_menus", ["second_course_id"], name: "index_second_courses_menus_on_second_course_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.integer  "organization_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

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

ActiveRecord::Schema.define(version: 2019_06_30_184646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "device_snapshots", force: :cascade do |t|
    t.bigint "device_id"
    t.datetime "taken_at", null: false
    t.decimal "temperature_celsius", precision: 5, scale: 2, null: false
    t.decimal "humidity_percentage", precision: 5, scale: 2, null: false
    t.decimal "carbon_monoxide_ppm", precision: 6, scale: 3, null: false
    t.string "status", limit: 150, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_device_snapshots_on_device_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "serial_number", null: false
    t.string "firmware_version", null: false
    t.string "auth_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_token"], name: "index_devices_on_auth_token", unique: true
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "device_snapshot_id", null: false
    t.datetime "occurred_at", null: false
    t.datetime "resolved_at"
    t.string "kind", null: false
    t.bigint "resolved_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_issues_on_device_id"
    t.index ["device_snapshot_id"], name: "index_issues_on_device_snapshot_id"
    t.index ["resolved_by_id"], name: "index_issues_on_resolved_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "device_snapshots", "devices"
  add_foreign_key "issues", "device_snapshots"
  add_foreign_key "issues", "devices"
  add_foreign_key "issues", "users", column: "resolved_by_id"
end

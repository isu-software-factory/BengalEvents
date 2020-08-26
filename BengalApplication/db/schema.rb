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

ActiveRecord::Schema.define(version: 2020_08_19_222833) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "equipment"
    t.boolean "ismakeahead"
    t.boolean "iscompetetion"
    t.integer "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_id"
    t.integer "max_team_size"
    t.index ["event_id"], name: "index_activities_on_event_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_assignments_on_role_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_date"
    t.string "name"
    t.string "description"
    t.boolean "visible", default: true
    t.datetime "visible_constraint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groupings", force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_groupings_on_team_id"
    t.index ["user_id"], name: "index_groupings_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_registrations_on_session_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "room_number"
    t.string "room_name"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_rooms_on_location_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "activity_id"
    t.integer "room_id"
    t.index ["activity_id"], name: "index_sessions_on_activity_id"
    t.index ["room_id"], name: "index_sessions_on_room_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "primary_color", default: "#6d6e71"
    t.string "secondary_color", default: "#f47920"
    t.string "additional_color", default: "#f69240"
    t.string "font", default: "Arial"
    t.string "site_name", default: "Bengal Stem Day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setups", force: :cascade do |t|
    t.boolean "configure", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "school_name"
    t.integer "chaperone_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "team_registrations", force: :cascade do |t|
    t.integer "team_id"
    t.integer "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_team_registrations_on_session_id"
    t.index ["team_id"], name: "index_team_registrations_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "lead"
    t.string "team_name"
    t.integer "waitlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["waitlist_id"], name: "index_teams_on_waitlist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "user_name"
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "waitlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["teacher_id"], name: "index_users_on_teacher_id"
    t.index ["waitlist_id"], name: "index_users_on_waitlist_id"
  end

  create_table "waitlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "session_id"
    t.index ["session_id"], name: "index_waitlists_on_session_id"
  end

end

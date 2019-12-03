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

ActiveRecord::Schema.define(version: 2019_12_03_014204) do

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coordinators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "event_details", force: :cascade do |t|
    t.integer "capacity"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_started"
    t.index ["event_id"], name: "index_event_details_on_event_id"
  end

# Could not dump table "events" because of following StandardError
#   Unknown type 'bool' for column 'isCompetetion'

  create_table "groupings", force: :cascade do |t|
    t.integer "team_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_groupings_on_student_id"
    t.index ["team_id"], name: "index_groupings_on_team_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "occasion_id"
    t.index ["occasion_id"], name: "index_locations_on_occasion_id"
  end

  create_table "occasions", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coordinator_id"
    t.string "description"
    t.index ["coordinator_id"], name: "index_occasions_on_coordinator_id"
  end

  create_table "participants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.string "member_type"
    t.integer "waitlist_id"
    t.index ["waitlist_id"], name: "index_participants_on_waitlist_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "participant_id"
    t.integer "event_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_detail_id"], name: "index_registrations_on_event_detail_id"
    t.index ["participant_id"], name: "index_registrations_on_participant_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"
    t.string "name"
    t.index ["teacher_id"], name: "index_students_on_teacher_id"
  end

  create_table "supervisors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "director_id"
    t.string "director_type"
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "school"
    t.integer "chaperone_count"
    t.integer "student_count"
    t.string "name"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "lead"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "time_slots", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_id"
    t.index ["location_id"], name: "index_time_slots_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "meta_id"
    t.string "meta_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "waitlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_detail_id"
    t.index ["event_detail_id"], name: "index_waitlists_on_event_detail_id"
  end

end

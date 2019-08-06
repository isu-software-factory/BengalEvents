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

ActiveRecord::Schema.define(version: 2019_08_04_233200) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coordinators", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "event_details", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "capacity"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.index ["event_id"], name: "index_event_details_on_event_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "isMakeAhead"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "occasion_id"
    t.bigint "sponsor_id"
    t.index ["occasion_id"], name: "index_events_on_occasion_id"
    t.index ["sponsor_id"], name: "index_events_on_sponsor_id"
  end

  create_table "groupings", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_groupings_on_student_id"
    t.index ["team_id"], name: "index_groupings_on_team_id"
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "occasion_id"
    t.string "name"
    t.index ["occasion_id"], name: "index_locations_on_occasion_id"
  end

  create_table "occasions", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coordinator_id"
    t.string "description"
    t.index ["coordinator_id"], name: "index_occasions_on_coordinator_id"
  end

  create_table "participants", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.string "member_type"
  end

  create_table "registrations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "participant_id"
    t.bigint "event_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_detail_id"], name: "index_registrations_on_event_detail_id"
    t.index ["participant_id"], name: "index_registrations_on_participant_id"
  end

  create_table "sponsors", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "students", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "teacher_id"
    t.string "name"
    t.index ["teacher_id"], name: "index_students_on_teacher_id"
  end

  create_table "teachers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "school"
    t.integer "chaperone_count"
    t.integer "student_count"
    t.string "name"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "lead"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "time_slots", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.integer "interval"
    t.index ["location_id"], name: "index_time_slots_on_location_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
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

  add_foreign_key "event_details", "events"
  add_foreign_key "events", "occasions"
  add_foreign_key "events", "sponsors"
  add_foreign_key "groupings", "students"
  add_foreign_key "groupings", "teams"
  add_foreign_key "locations", "occasions"
  add_foreign_key "occasions", "coordinators"
  add_foreign_key "registrations", "event_details"
  add_foreign_key "registrations", "participants"
  add_foreign_key "students", "teachers"
  add_foreign_key "time_slots", "locations"
end

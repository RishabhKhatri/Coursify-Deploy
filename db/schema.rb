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

ActiveRecord::Schema.define(version: 20170620104615) do

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "summary",    limit: 65535
    t.string   "code"
    t.integer  "teacher_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "archived",                 default: false
    t.index ["teacher_id"], name: "index_courses_on_teacher_id", using: :btree
  end

  create_table "institutes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "subdomain"
    t.string   "admin"
  end

  create_table "resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "instructions"
    t.integer  "course_id"
    t.string   "video"
    t.string   "attachment"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_resources_on_course_id", using: :btree
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "session_id",               null: false
    t.string   "cas_ticket"
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["cas_ticket"], name: "index_sessions_on_cas_ticket", using: :btree
    t.index ["session_id"], name: "index_sessions_on_session_id", using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "students", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "contact"
    t.string   "password_digest"
    t.string   "picture"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",             default: false
    t.string   "imglink"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.date     "dob"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_students_on_email", using: :btree
  end

  create_table "teachers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "contact"
    t.string   "expertise"
    t.string   "password_digest"
    t.string   "picture"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",             default: false
    t.string   "imglink"
    t.integer  "institute_id"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_teachers_on_email", unique: true, using: :btree
    t.index ["institute_id"], name: "index_teachers_on_institute_id", using: :btree
  end

  add_foreign_key "courses", "teachers"
  add_foreign_key "resources", "courses"
  add_foreign_key "teachers", "institutes"
end

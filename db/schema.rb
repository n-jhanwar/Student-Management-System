# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_13_171507) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.date "attendance_date", null: false
    t.datetime "created_at", null: false
    t.bigint "enrollment_id", null: false
    t.text "remarks"
    t.string "status", default: "present", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_id", "attendance_date"], name: "index_attendances_on_enrollment_id_and_attendance_date", unique: true
    t.index ["enrollment_id"], name: "index_attendances_on_enrollment_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "enrollment_date", null: false
    t.string "status", default: "enrolled"
    t.bigint "student_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id", "subject_id"], name: "index_enrollments_on_student_id_and_subject_id", unique: true
    t.index ["student_id"], name: "index_enrollments_on_student_id"
    t.index ["subject_id"], name: "index_enrollments_on_subject_id"
  end

  create_table "grades", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "enrollment_id", null: false
    t.date "graded_date"
    t.decimal "maximum_score", precision: 5, scale: 2
    t.decimal "score", precision: 5, scale: 2
    t.datetime "updated_at", null: false
    t.decimal "weight", precision: 5, scale: 2
    t.index ["enrollment_id"], name: "index_grades_on_enrollment_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "contact", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.date "hire_date", null: false
    t.string "instructor_id", null: false
    t.string "last_name", null: false
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_instructors_on_email", unique: true
    t.index ["instructor_id"], name: "index_instructors_on_instructor_id", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.string "contact", null: false
    t.datetime "created_at", null: false
    t.date "date_of_admission", null: false
    t.date "date_of_birth", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "status", default: "active"
    t.string "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["student_id"], name: "index_students_on_student_id", unique: true
  end

  create_table "subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "instructors_id", null: false
    t.string "semester", null: false
    t.string "subject_code", null: false
    t.string "subject_name", null: false
    t.datetime "updated_at", null: false
    t.index ["instructors_id"], name: "index_subjects_on_instructors_id"
    t.index ["subject_code"], name: "index_subjects_on_subject_code", unique: true
  end

  add_foreign_key "attendances", "enrollments"
  add_foreign_key "enrollments", "students"
  add_foreign_key "enrollments", "subjects"
  add_foreign_key "grades", "enrollments"
  add_foreign_key "subjects", "instructors", column: "instructors_id"
end

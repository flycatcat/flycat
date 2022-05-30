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

ActiveRecord::Schema.define(version: 2022_05_30_064713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bulletins", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "slug"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_bulletins_on_company_id"
    t.index ["slug"], name: "index_bulletins_on_slug", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "title"
    t.string "ubn"
    t.string "person_in_charge"
    t.string "address"
    t.string "contact_person"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "department_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.datetime "deleted_at"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_departments_on_company_id"
    t.index ["slug"], name: "index_departments_on_slug", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.boolean "all_day"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "title"
    t.string "content"
    t.date "date"
    t.bigint "work_shift_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "vacation_set"
    t.string "mode"
    t.index ["work_shift_id"], name: "index_events_on_work_shift_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_no"
    t.string "username"
    t.integer "amount"
    t.string "transaction_no"
    t.text "memo"
    t.string "pay_type"
    t.datetime "pay_at"
    t.string "card_last_4_no"
    t.integer "newebpay_amt"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "staff_no"
    t.string "name"
    t.string "tel"
    t.string "gender"
    t.date "start_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.datetime "deleted_at"
    t.bigint "company_id"
    t.string "department"
    t.string "job_title"
    t.bigint "user_id"
    t.date "end_at"
    t.string "work_shift_title"
    t.index ["company_id"], name: "index_profiles_on_company_id"
    t.index ["slug"], name: "index_profiles_on_slug", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "punchcards", force: :cascade do |t|
    t.datetime "punch_in_at"
    t.datetime "punch_out_at"
    t.decimal "body_temperature"
    t.boolean "first_punch"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["user_id"], name: "index_punchcards_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role", default: "admin"
    t.string "provider"
    t.string "uid"
    t.bigint "company_id"
    t.string "slug"
    t.string "title"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "vacations", force: :cascade do |t|
    t.string "vacation_type"
    t.date "vacation_at"
    t.string "status"
    t.string "reason"
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "slug"
    t.decimal "hour"
    t.index ["company_id"], name: "index_vacations_on_company_id"
    t.index ["slug"], name: "index_vacations_on_slug", unique: true
    t.index ["user_id"], name: "index_vacations_on_user_id"
  end

  create_table "work_shifts", force: :cascade do |t|
    t.string "title"
    t.string "kind"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_work_shifts_on_company_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bulletins", "companies"
  add_foreign_key "departments", "companies"
  add_foreign_key "events", "work_shifts"
  add_foreign_key "profiles", "companies"
  add_foreign_key "profiles", "users"
  add_foreign_key "punchcards", "users"
  add_foreign_key "users", "companies"
  add_foreign_key "vacations", "companies"
  add_foreign_key "vacations", "users"
  add_foreign_key "work_shifts", "companies"
end

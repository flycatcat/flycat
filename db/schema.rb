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

ActiveRecord::Schema.define(version: 2022_05_17_093319) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "vat_number"
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
    t.integer "user_id"
    t.text "memo"
    t.string "pay_type"
    t.datetime "pay_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "card_last_4_no"
    t.integer "newebpay_amt"
    t.string "status"
    t.index ["order_no"], name: "index_orders_on_order_no", unique: true
  end

  create_table "staffs", force: :cascade do |t|
    t.string "staff_no"
    t.string "name"
    t.string "tel"
    t.string "gender"
    t.date "start_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.datetime "deleted_at"
    t.index ["slug"], name: "index_staffs_on_slug", unique: true
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
    t.string "title"
    t.integer "vat_number"
    t.string "principal"
    t.string "address"
    t.string "contact_person"
    t.integer "staff_no"
    t.string "name"
    t.date "start_at"
    t.string "job_title"
    t.string "department"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bulletins", "companies"
  add_foreign_key "departments", "companies"
  add_foreign_key "users", "companies"
end

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

ActiveRecord::Schema[7.0].define(version: 2023_10_10_221427) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "employee_name"
    t.string "action_type"
    t.string "table_name"
    t.text "json_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.text "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_contact_information", force: :cascade do |t|
    t.string "contact_info"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_contact_information_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "coordinate"
    t.text "info"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_reports", force: :cascade do |t|
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "monthly_report_id"
    t.index ["monthly_report_id"], name: "index_daily_reports_on_monthly_report_id"
  end

  create_table "employee_contact_information", force: :cascade do |t|
    t.string "contact_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_employee_contact_information_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "role", default: "employee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "ledgers", force: :cascade do |t|
    t.bigint "agent_id"
    t.date "date"
    t.integer "withdraw"
    t.integer "deposit"
    t.json "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_ledgers_on_agent_id"
    t.index ["date"], name: "index_ledgers_on_date"
  end

  create_table "monthly_reports", force: :cascade do |t|
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_records", force: :cascade do |t|
    t.bigint "subscription_record_id", null: false
    t.bigint "employee_id", null: false
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_payment_records_on_created_at"
    t.index ["employee_id"], name: "index_payment_records_on_employee_id"
    t.index ["subscription_record_id"], name: "index_payment_records_on_subscription_record_id"
  end

  create_table "subscription_records", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "subscription_type_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_fully_paid"
    t.decimal "pay"
    t.text "note"
    t.decimal "cost"
    t.string "category"
    t.string "assigned_employee"
    t.index ["client_id"], name: "index_subscription_records_on_client_id"
    t.index ["employee_id"], name: "index_subscription_records_on_employee_id"
    t.index ["subscription_type_id"], name: "index_subscription_records_on_subscription_type_id"
  end

  create_table "subscription_types", force: :cascade do |t|
    t.string "category"
    t.decimal "cost"
    t.decimal "profit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "client_contact_information", "clients"
  add_foreign_key "daily_reports", "monthly_reports"
  add_foreign_key "employee_contact_information", "employees"
  add_foreign_key "ledgers", "agents"
  add_foreign_key "payment_records", "employees"
  add_foreign_key "payment_records", "subscription_records"
  add_foreign_key "subscription_records", "clients"
  add_foreign_key "subscription_records", "employees"
  add_foreign_key "subscription_records", "subscription_types"
end

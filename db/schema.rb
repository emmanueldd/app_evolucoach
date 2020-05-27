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

ActiveRecord::Schema.define(version: 20200527125749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "course"
    t.datetime "start_time"
    t.boolean "available", default: false
    t.boolean "taken", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "slug"
    t.string "phone"
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.bigint "user_id"
    t.string "city"
    t.string "address"
    t.string "country"
    t.string "dpt"
    t.string "zipcode"
    t.date "birth_date"
    t.boolean "male"
    t.integer "age"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_clients_on_slug", unique: true
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "client_id"
    t.bigint "availability_id"
    t.datetime "start_time"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["availability_id"], name: "index_courses_on_availability_id"
    t.index ["client_id"], name: "index_courses_on_client_id"
    t.index ["order_id"], name: "index_courses_on_order_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "crm_comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "user_has_client_id"
    t.bigint "client_id"
    t.text "comment"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_crm_comments_on_client_id"
    t.index ["user_has_client_id"], name: "index_crm_comments_on_user_has_client_id"
    t.index ["user_id"], name: "index_crm_comments_on_user_id"
  end

  create_table "exercise_categories", force: :cascade do |t|
    t.string "name"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.bigint "exercise_category_id"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_category_id"], name: "index_exercises_on_exercise_category_id"
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

  create_table "leads", force: :cascade do |t|
    t.bigint "user_id"
    t.string "email", default: "", null: false
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "slug"
    t.string "phone"
    t.string "avatar"
    t.string "nickname"
    t.string "city"
    t.string "address"
    t.string "country"
    t.string "dpt"
    t.string "zipcode"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "male"
    t.integer "age"
    t.index ["user_id"], name: "index_leads_on_user_id"
  end

  create_table "order_has_items", force: :cascade do |t|
    t.bigint "order_id"
    t.string "item_type"
    t.bigint "item_id"
    t.integer "quantity"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_order_has_items_on_item_type_and_item_id"
    t.index ["order_id"], name: "index_order_has_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "user_id"
    t.integer "status"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "packs", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.string "description"
    t.string "bg_color"
    t.integer "position", default: 0
    t.string "color"
    t.string "pack_type"
    t.integer "unit_price"
    t.integer "total_price"
    t.integer "nb_of_courses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: false
    t.index ["user_id"], name: "index_packs_on_user_id"
  end

  create_table "program_steps", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "program_id"
    t.bigint "exercise_id"
    t.string "name"
    t.integer "step_type"
    t.boolean "published", default: false
    t.string "round"
    t.string "repetition"
    t.string "charge"
    t.string "cadence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exercise_category_id"
    t.index ["exercise_category_id"], name: "index_program_steps_on_exercise_category_id"
    t.index ["exercise_id"], name: "index_program_steps_on_exercise_id"
    t.index ["program_id"], name: "index_program_steps_on_program_id"
    t.index ["user_id"], name: "index_program_steps_on_user_id"
  end

  create_table "programs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "client_id"
    t.string "name"
    t.string "slug"
    t.text "description"
    t.integer "price"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.integer "frequency"
    t.string "cover"
    t.text "rest_note"
    t.text "info_note"
    t.index ["client_id"], name: "index_programs_on_client_id"
    t.index ["slug"], name: "index_programs_on_slug", unique: true
    t.index ["user_id"], name: "index_programs_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "client_id"
    t.integer "score"
    t.text "comment", default: ""
    t.boolean "published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_ratings_on_client_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "user_has_clients", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "client_id"
    t.bigint "lead_id"
    t.boolean "is_client", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_user_has_clients_on_client_id"
    t.index ["lead_id"], name: "index_user_has_clients_on_lead_id"
    t.index ["user_id"], name: "index_user_has_clients_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname", default: ""
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.text "description", default: ""
    t.integer "financial_goal", default: 0
    t.string "slug"
    t.string "phone"
    t.string "avatar"
    t.integer "coaching_count", default: 0
    t.float "score", default: 5.0
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "availabilities", "users"
  add_foreign_key "clients", "users"
  add_foreign_key "courses", "availabilities"
  add_foreign_key "courses", "clients"
  add_foreign_key "courses", "orders"
  add_foreign_key "courses", "users"
  add_foreign_key "crm_comments", "clients"
  add_foreign_key "crm_comments", "user_has_clients"
  add_foreign_key "crm_comments", "users"
  add_foreign_key "exercises", "exercise_categories"
  add_foreign_key "leads", "users"
  add_foreign_key "order_has_items", "orders"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "users"
  add_foreign_key "packs", "users"
  add_foreign_key "program_steps", "exercise_categories"
  add_foreign_key "program_steps", "exercises"
  add_foreign_key "program_steps", "programs"
  add_foreign_key "program_steps", "users"
  add_foreign_key "programs", "clients"
  add_foreign_key "programs", "users"
  add_foreign_key "ratings", "clients"
  add_foreign_key "ratings", "users"
  add_foreign_key "user_has_clients", "clients"
  add_foreign_key "user_has_clients", "leads"
  add_foreign_key "user_has_clients", "users"
end

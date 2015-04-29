# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 120150319160428) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "suppliers_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "include_vat",  limit: 4
  end

  create_table "communication_media", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "middle_name",            limit: 255
    t.string   "last_name",              limit: 255
    t.string   "phone",                  limit: 255
    t.string   "address",                limit: 255
    t.decimal  "total_purchased_amount",             precision: 10
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "communication_details",  limit: 255
    t.boolean  "status",                 limit: 1
    t.integer  "communication_media_id", limit: 4
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "category_id",      limit: 4
    t.integer  "quantity",         limit: 4
    t.integer  "unit_price",       limit: 4
    t.string   "expiration_date",  limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "purchase_id",      limit: 4
    t.decimal  "sell_price",                   precision: 10
    t.decimal  "total",                        precision: 10
    t.string   "item_id",          limit: 255
    t.integer  "current_quantity", limit: 4
    t.decimal  "margin",                       precision: 10
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "supplier_id", limit: 4
    t.string   "invoice_id",  limit: 255
    t.integer  "amount",      limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.date     "date"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer  "customer_id",    limit: 4
    t.decimal  "discount",                   precision: 10, scale: 2
    t.decimal  "amount",                     precision: 10, scale: 2
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "payment_method", limit: 255
  end

  create_table "sells", force: :cascade do |t|
    t.integer  "customer_id",    limit: 4
    t.decimal  "amount",                     precision: 10, scale: 2
    t.decimal  "discount",                   precision: 10, scale: 2
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "payment_method", limit: 255
  end

  create_table "sold_items", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "rate",                   precision: 10, scale: 2
    t.decimal  "total",                  precision: 10, scale: 2
    t.integer  "quantity",   limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "sell_id",    limit: 4
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "organization_name", limit: 255
    t.string   "address",           limit: 255
    t.string   "contact_person",    limit: 255
    t.string   "contact_no",        limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

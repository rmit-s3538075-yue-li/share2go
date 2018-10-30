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

ActiveRecord::Schema.define(version: 20181019064709) do

  create_table "admins", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "car_id"
    t.integer  "user_id"
    t.datetime "pickup_time"
    t.datetime "return_time"
    t.integer  "pickup_location_id"
    t.integer  "return_location_id"
    t.string   "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "book_time"
  end

  create_table "cars", force: :cascade do |t|
    t.string   "image"
    t.string   "make"
    t.integer  "year"
    t.string   "model"
    t.string   "body_type"
    t.string   "number_plate"
    t.string   "condition"
    t.integer  "price"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "location_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id"
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id"

  create_table "locations", force: :cascade do |t|
    t.string   "number"
    t.string   "street"
    t.string   "suburb"
    t.string   "state"
    t.integer  "postcode"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "booking_id"
    t.integer  "car_id"
    t.integer  "rating"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "booking_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "car_id"
    t.datetime "sentdate"
    t.string   "car_make"
    t.boolean  "read"
    t.datetime "time"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "license_no"
    t.string   "mobile"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "email_confirmed",        default: false
    t.string   "confirm_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_send_at"
    t.integer  "credit"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

end

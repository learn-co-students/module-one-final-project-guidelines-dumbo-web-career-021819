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

ActiveRecord::Schema.define(version: 20190305195450) do

  create_table "customers", force: :cascade do |t|
    t.string "name"
  end

  create_table "foods", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.float   "price"
    t.integer "restaurant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "restaurant_id"
    t.float   "total",             default: 0.0
    t.string  "location"
    t.boolean "received?",         default: false
    t.string  "deliver_or_pickup", default: "deliver"
    t.string  "cash_or_card"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "location"
  end

end

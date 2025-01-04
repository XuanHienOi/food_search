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

ActiveRecord::Schema[8.0].define(version: 2025_01_04_094337) do
  create_table "foods", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "restaurant_item_id"
    t.string "restaurant_name"
    t.string "restaurant_address"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "old_price", precision: 10, scale: 2
    t.string "item_name"
    t.text "item_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_foods_on_restaurant_id"
    t.index ["restaurant_item_id"], name: "index_foods_on_restaurant_item_id", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.integer "classify"
    t.integer "restaurant_id"
    t.string "name"
    t.float "rating"
    t.float "latitude"
    t.float "longitude"
    t.string "display_address"
    t.string "address"
    t.integer "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end

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

ActiveRecord::Schema[7.0].define(version: 2022_04_06_130520) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "product_calories", force: :cascade do |t|
    t.float "calories"
    t.integer "quantity"
    t.string "unit"
    t.bigint "product_id"
    t.index ["product_id"], name: "index_product_calories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "unit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_type"
  end

  create_table "recipe_products", force: :cascade do |t|
    t.integer "quantity"
    t.integer "recipe_id"
    t.integer "product_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "preparation_time"
    t.float "calories"
  end

  create_table "shopping_list_products", force: :cascade do |t|
    t.bigint "shopping_list_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_shopping_list_products_on_product_id"
    t.index ["shopping_list_id"], name: "index_shopping_list_products_on_shopping_list_id"
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.string "name", default: "shopping list"
    t.date "shopping_day"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

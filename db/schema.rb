# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_29_195830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredient_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "quantity"
    t.string "unit"
    t.string "size"
    t.string "modifier"
    t.integer "ingredient_set_id"
    t.string "original_string"
    t.string "written_quantity"
    t.string "written_unit"
    t.string "ingredient"
    t.index ["ingredient_set_id"], name: "index_ingredient_entries_on_ingredient_set_id"
  end

  create_table "ingredient_sets", force: :cascade do |t|
    t.string "title"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recipe_id"
  end

  create_table "method_steps", force: :cascade do |t|
    t.integer "position"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recipe_id"
    t.index ["recipe_id"], name: "index_method_steps_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "total_time"
    t.text "introduction"
    t.integer "serves"
    t.integer "makes"
    t.string "makes_unit"
    t.string "recipe_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "image_url"
    t.string "tags"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recipe_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.index ["recipe_id"], name: "index_tags_on_recipe_id"
    t.index ["taggable_type", "taggable_id"], name: "index_tags_on_taggable_type_and_taggable_id"
  end

end

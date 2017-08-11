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

ActiveRecord::Schema.define(version: 20170811033027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pc_parts", force: :cascade do |t|
    t.bigint "physical_color_id"
    t.integer "percentage", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["physical_color_id"], name: "index_pc_parts_on_physical_color_id"
  end

  create_table "pc_pigment_parts", force: :cascade do |t|
    t.bigint "physical_color_id"
    t.bigint "pigment_id"
    t.integer "percentage", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["physical_color_id"], name: "index_pc_pigment_parts_on_physical_color_id"
    t.index ["pigment_id"], name: "index_pc_pigment_parts_on_pigment_id"
  end

  create_table "pc_tint_parts", force: :cascade do |t|
    t.bigint "physical_color_id"
    t.bigint "tint_id"
    t.integer "percentage", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["physical_color_id"], name: "index_pc_tint_parts_on_physical_color_id"
    t.index ["tint_id"], name: "index_pc_tint_parts_on_tint_id"
  end

  create_table "pc_white_base_parts", force: :cascade do |t|
    t.bigint "physical_color_id"
    t.bigint "white_base_id"
    t.integer "percentage", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["physical_color_id"], name: "index_pc_white_base_parts_on_physical_color_id"
    t.index ["white_base_id"], name: "index_pc_white_base_parts_on_white_base_id"
  end

  create_table "physical_colors", force: :cascade do |t|
    t.string "name", limit: 40
    t.decimal "component_l", precision: 8, scale: 4
    t.decimal "component_a", precision: 8, scale: 4
    t.decimal "component_b", precision: 8, scale: 4
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pigments", force: :cascade do |t|
    t.string "name", limit: 40
    t.string "type", limit: 30
    t.integer "concentration"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tints", force: :cascade do |t|
    t.string "name", limit: 40
    t.string "type", limit: 30
    t.integer "concentration"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "white_bases", force: :cascade do |t|
    t.string "name", limit: 40
    t.string "type", limit: 30
    t.integer "concentration"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pc_parts", "physical_colors"
  add_foreign_key "pc_pigment_parts", "physical_colors"
  add_foreign_key "pc_pigment_parts", "pigments"
  add_foreign_key "pc_tint_parts", "physical_colors"
  add_foreign_key "pc_tint_parts", "tints"
  add_foreign_key "pc_white_base_parts", "physical_colors"
  add_foreign_key "pc_white_base_parts", "white_bases", column: "white_base_id"
end

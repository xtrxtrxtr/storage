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

ActiveRecord::Schema[7.1].define(version: 2024_05_19_183846) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "components", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.string "name", null: false, collation: "C"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_components_on_lower_name", unique: true
    t.index ["uuid"], name: "index_components_on_uuid", unique: true
  end

  create_table "images", comment: "Uploaded images", force: :cascade do |t|
    t.bigint "component_id"
    t.uuid "uuid", null: false
    t.uuid "user_uuid", comment: "Owner (UUID)"
    t.inet "ip"
    t.string "image", null: false, comment: "Attached image (for CarrierWave)"
    t.string "image_alt_text", default: "", null: false
    t.string "caption", comment: "Image caption for figures"
    t.string "source_name"
    t.string "source_link"
    t.string "checksum", comment: "Checksum for avoiding doubles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checksum"], name: "index_images_on_checksum"
    t.index ["component_id"], name: "index_images_on_component_id"
    t.index ["user_uuid"], name: "index_images_on_user_uuid"
    t.index ["uuid"], name: "index_images_on_uuid", unique: true
  end

  add_foreign_key "images", "components", on_update: :cascade, on_delete: :nullify
end

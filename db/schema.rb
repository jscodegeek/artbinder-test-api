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

ActiveRecord::Schema.define(version: 20170607211427) do

  create_table "artists", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "description"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artworks", force: :cascade do |t|
    t.integer "artist_id"
    t.string "title"
    t.string "description"
    t.integer "price"
    t.integer "width"
    t.integer "height"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artworks_on_artist_id"
  end

  create_table "image_files", force: :cascade do |t|
    t.integer "artwork_id"
    t.string "name"
    t.string "base64"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id"], name: "index_image_files_on_artwork_id"
  end

end

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

ActiveRecord::Schema.define(version: 20140209124727) do

  create_table "artist_band_join_requests", force: true do |t|
    t.integer  "artist_id"
    t.integer  "band_id"
    t.boolean  "artist_accepted", default: false
    t.boolean  "band_accepted",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artist_band_join_requests", ["artist_id"], name: "index_artist_band_join_requests_on_artist_id", using: :btree
  add_index "artist_band_join_requests", ["band_id"], name: "index_artist_band_join_requests_on_band_id", using: :btree

  create_table "artist_band_relations", force: true do |t|
    t.integer  "artist_id"
    t.integer  "band_id"
    t.boolean  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artist_band_relations", ["artist_id", "band_id"], name: "index_artist_band_relations_on_artist_id_and_band_id", unique: true, using: :btree

  create_table "artist_genre_relations", force: true do |t|
    t.integer  "artist_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artist_genre_relations", ["artist_id", "genre_id"], name: "index_artist_genre_relations_on_artist_id_and_genre_id", unique: true, using: :btree

  create_table "artist_instrument_relations", force: true do |t|
    t.integer  "artist_id"
    t.integer  "instrument_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artist_instrument_relations", ["artist_id", "instrument_id"], name: "uniqueness", unique: true, using: :btree

  create_table "artists", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "stage_name"
    t.string   "about"
    t.boolean  "admin",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.datetime "birthday"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "link_facebook"
    t.string   "link_youtube"
    t.string   "link_website"
    t.string   "remember_token"
    t.integer  "profile_picture_id"
    t.integer  "cover_picture_id"
  end

  add_index "artists", ["email"], name: "index_artists_on_email", unique: true, using: :btree
  add_index "artists", ["remember_token"], name: "index_artists_on_remember_token", using: :btree
  add_index "artists", ["username"], name: "index_artists_on_username", unique: true, using: :btree

  create_table "bands", force: true do |t|
    t.string   "name"
    t.string   "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "page"
    t.string   "link_website"
    t.string   "link_facebook"
    t.string   "link_youtube"
    t.datetime "established"
  end

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "pictures", ["artist_id"], name: "index_pictures_on_artist_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "content"
    t.string   "link"
    t.integer  "artist_id"
    t.integer  "band_id"
    t.integer  "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

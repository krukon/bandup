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

ActiveRecord::Schema.define(version: 20140121182819) do

  create_table "artist_band_relations", force: true do |t|
    t.integer  "artist_id"
    t.integer  "band_id"
    t.boolean  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artist_band_relations", ["artist_id", "band_id"], name: "index_artist_band_relations_on_artist_id_and_band_id", unique: true

  create_table "artist_instrument_relations", force: true do |t|
    t.integer  "artist_id"
    t.integer  "instrument_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "stage_name"
    t.string   "about"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["email"], name: "index_artists_on_email", unique: true

  create_table "bands", force: true do |t|
    t.string   "name"
    t.string   "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

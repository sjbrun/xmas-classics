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

ActiveRecord::Schema.define(version: 20161204221539) do

  create_table "lyrics", force: :cascade do |t|
    t.string   "word"
    t.string   "part_of_speech"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "song_id"
    t.integer  "madlib_id"
  end

  add_index "lyrics", ["madlib_id"], name: "index_lyrics_on_madlib_id"
  add_index "lyrics", ["song_id"], name: "index_lyrics_on_song_id"

  create_table "madlibs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "song_id"
  end

  add_index "madlibs", ["song_id"], name: "index_madlibs_on_song_id"

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.text     "lines"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "audio"
  end

end

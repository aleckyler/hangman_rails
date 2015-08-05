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

ActiveRecord::Schema.define(version: 20150805181629) do

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.string   "word"
    t.string   "lives"
    t.string   "underscore_array"
    t.string   "word_array"
    t.string   "available_letters"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "host_name"
    t.string   "player_name"
  end

  create_table "plays", force: :cascade do |t|
    t.text     "guess"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "plays", ["game_id"], name: "index_plays_on_game_id"

end

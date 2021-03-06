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

ActiveRecord::Schema.define(version: 2018_10_11_002756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charts", force: :cascade do |t|
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "country_id"
    t.integer "song_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "country_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "name"
    t.string "artist"
    t.string "spotify_id"
    t.float "acousticness"
    t.float "danceability"
    t.integer "duration_ms"
    t.float "energy"
    t.float "instrumentalness"
    t.integer "key"
    t.integer "liveness"
    t.integer "mode"
    t.float "speechiness"
    t.float "tempo"
    t.integer "time_signature"
    t.float "valence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

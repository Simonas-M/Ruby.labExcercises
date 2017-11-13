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

ActiveRecord::Schema.define(version: 20171110103935) do

  create_table "actors", force: :cascade do |t|
    t.string "name", limit: 30
    t.string "surname", limit: 30
    t.integer "crew_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crew_id"], name: "index_actors_on_crew_id"
  end

  create_table "cinemas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crews", force: :cascade do |t|
    t.integer "info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["info_id"], name: "index_crews_on_info_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.string "title", limit: 20
    t.string "summary", limit: 500
    t.integer "genre_id"
    t.integer "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_descriptions_on_genre_id"
    t.index ["movie_id"], name: "index_descriptions_on_movie_id"
  end

  create_table "directors", force: :cascade do |t|
    t.string "name", limit: 30
    t.string "surname", limit: 30
    t.integer "crew_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crew_id"], name: "index_directors_on_crew_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "infos", force: :cascade do |t|
    t.integer "duration"
    t.datetime "release_date"
    t.integer "rating_id"
    t.integer "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_infos_on_movie_id"
    t.index ["rating_id"], name: "index_infos_on_rating_id"
  end

  create_table "movies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.string "name", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repertoire_movies", force: :cascade do |t|
    t.integer "repertoire_id"
    t.integer "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_repertoire_movies_on_movie_id"
    t.index ["repertoire_id"], name: "index_repertoire_movies_on_repertoire_id"
  end

  create_table "repertoires", force: :cascade do |t|
    t.integer "cinema_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id"], name: "index_repertoires_on_cinema_id"
  end

  create_table "screenings", force: :cascade do |t|
    t.datetime "time"
    t.integer "available_seat_count"
    t.integer "movie_id"
    t.integer "screen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_screenings_on_movie_id"
    t.index ["screen_id"], name: "index_screenings_on_screen_id"
  end

  create_table "screens", force: :cascade do |t|
    t.string "title", limit: 20
    t.integer "seat_count", limit: 500
    t.integer "cinema_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id"], name: "index_screens_on_cinema_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.decimal "price"
    t.integer "seat_no"
    t.integer "screening_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screening_id"], name: "index_tickets_on_screening_id"
  end

  create_table "writers", force: :cascade do |t|
    t.string "name", limit: 30
    t.string "surname", limit: 30
    t.integer "crew_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crew_id"], name: "index_writers_on_crew_id"
  end

end

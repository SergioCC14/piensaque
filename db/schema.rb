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

ActiveRecord::Schema.define(version: 20140601194707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "musics", force: true do |t|
    t.text     "title"
    t.text     "artist"
    t.text     "album"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "genre"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "song_file_name"
    t.string   "song_content_type"
    t.integer  "song_file_size"
    t.datetime "song_updated_at"
    t.string   "ogg_song_file_name"
    t.string   "ogg_song_content_type"
    t.integer  "ogg_song_file_size"
    t.datetime "ogg_song_updated_at"
  end

  create_table "playlists", force: true do |t|
    t.string   "name"
    t.string   "genre"
    t.string   "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pnsqs", force: true do |t|
    t.text     "text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.integer  "user_id"
    t.string   "taste"
    t.integer  "to_user_id"
  end

  create_table "pnsqs_tags", force: true do |t|
    t.integer  "pnsq_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_invitations", force: true do |t|
    t.string   "email"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "token"
    t.boolean  "checked",    default: false
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_next_steps", force: true do |t|
    t.integer "user_id"
    t.boolean "dashboard_help"
    t.boolean "user_show_help"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "nick"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "rank"
    t.string   "remember_token"
    t.boolean  "mt_rock"
    t.boolean  "mt_pop"
    t.boolean  "mt_electronic"
    t.boolean  "mt_instrumental",     default: true
    t.boolean  "mt_jazz"
    t.string   "name"
    t.string   "surname"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "mt_country"
    t.boolean  "mt_hiphop"
    t.integer  "followers_count",     default: 0
    t.integer  "following_count",     default: 0
    t.text     "bio"
    t.boolean  "mt_classical",        default: false
    t.boolean  "mt_dance",            default: false
    t.boolean  "mt_heavy",            default: false
    t.boolean  "mt_reggae",           default: false
    t.boolean  "mt_funk",             default: false
    t.string   "password_salt"
    t.integer  "notifications_count", default: 0
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end

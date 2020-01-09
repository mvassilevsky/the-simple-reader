# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_14_205248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feeds", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.string "favicon_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url"], name: "index_feeds_on_url", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.integer "feed_id", null: false
    t.string "title"
    t.string "author"
    t.string "content"
    t.string "url"
    t.datetime "posted_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feed_id"], name: "index_posts_on_feed_id"
    t.index ["posted_at"], name: "index_posts_on_posted_at"
  end

  create_table "user_feeds", force: :cascade do |t|
    t.integer "user_id"
    t.integer "feed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feed_id"], name: "index_user_feeds_on_feed_id"
    t.index ["user_id", "feed_id"], name: "index_user_feeds_on_user_id_and_feed_id", unique: true
    t.index ["user_id"], name: "index_user_feeds_on_user_id"
  end

  create_table "user_posts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.boolean "read", default: false
    t.boolean "bookmarked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookmarked"], name: "index_user_posts_on_bookmarked"
    t.index ["post_id"], name: "index_user_posts_on_post_id"
    t.index ["read"], name: "index_user_posts_on_read"
    t.index ["user_id", "post_id"], name: "index_user_posts_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_user_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false, null: false
    t.boolean "unread_only", default: true, null: false
    t.boolean "new_posts_first", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

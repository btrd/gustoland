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

ActiveRecord::Schema.define(version: 20170309154416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_recipes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipe_id"
    t.index ["recipe_id"], name: "index_book_recipes_on_recipe_id", using: :btree
    t.index ["user_id"], name: "index_book_recipes_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string  "content"
    t.integer "user_id"
    t.integer "recipe_id"
    t.index ["recipe_id"], name: "index_comments_on_recipe_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "follower_subscriptions", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_follower_subscriptions_on_followed_id", using: :btree
    t.index ["follower_id"], name: "index_follower_subscriptions_on_follower_id", using: :btree
  end

  create_table "ingredients", force: :cascade do |t|
    t.string  "label"
    t.integer "quantity"
    t.string  "unit"
    t.integer "recipe_id"
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id", using: :btree
  end

  create_table "like_recipes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipe_id"
    t.index ["recipe_id"], name: "index_like_recipes_on_recipe_id", using: :btree
    t.index ["user_id"], name: "index_like_recipes_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.string  "content"
    t.boolean "seen",          default: false
    t.integer "ref_user_id"
    t.integer "ref_recipe_id"
    t.integer "user_id"
    t.index ["ref_recipe_id"], name: "index_notifications_on_ref_recipe_id", using: :btree
    t.index ["ref_user_id"], name: "index_notifications_on_ref_user_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "description"
    t.integer  "price"
    t.integer  "time"
    t.integer  "serving"
    t.date     "publication"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.text     "steps",       default: [],              array: true
    t.binary   "image"
    t.index ["user_id"], name: "index_recipes_on_user_id", using: :btree
  end

  create_table "recipes_tags", id: false, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "recipe_id"
    t.index ["recipe_id"], name: "index_recipes_tags_on_recipe_id", using: :btree
    t.index ["tag_id"], name: "index_recipes_tags_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname",        null: false
    t.string   "email",           null: false
    t.string   "name",            null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.binary   "image"
  end

  add_foreign_key "book_recipes", "recipes"
  add_foreign_key "book_recipes", "users"
  add_foreign_key "comments", "recipes"
  add_foreign_key "comments", "users"
  add_foreign_key "follower_subscriptions", "users", column: "followed_id"
  add_foreign_key "follower_subscriptions", "users", column: "follower_id"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "like_recipes", "recipes"
  add_foreign_key "like_recipes", "users"
  add_foreign_key "notifications", "recipes", column: "ref_recipe_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "ref_user_id"
  add_foreign_key "recipes", "users"
  add_foreign_key "recipes_tags", "recipes"
  add_foreign_key "recipes_tags", "tags"
end

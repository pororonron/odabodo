# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_06_03_024641) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "illustration_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_bookmarks_on_end_user_id"
    t.index ["illustration_id"], name: "index_bookmarks_on_illustration_id"
  end

  create_table "challenge_themes", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "theme_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_challenge_themes_on_end_user_id"
    t.index ["theme_id"], name: "index_challenge_themes_on_theme_id"
  end

  create_table "end_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.text "self_introduction"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.index ["email"], name: "index_end_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_end_users_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "illustration_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_favorites_on_end_user_id"
    t.index ["illustration_id"], name: "index_favorites_on_illustration_id"
  end

  create_table "follow_relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "illustration_comments", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "illustration_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_illustration_comments_on_end_user_id"
    t.index ["illustration_id"], name: "index_illustration_comments_on_illustration_id"
  end

  create_table "illustration_tag_middles", force: :cascade do |t|
    t.integer "illustration_id", null: false
    t.integer "illustration_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["illustration_id"], name: "index_illustration_tag_middles_on_illustration_id"
    t.index ["illustration_tag_id"], name: "index_illustration_tag_middles_on_illustration_tag_id"
  end

  create_table "illustration_tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "illustrations", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "theme_id", null: false
    t.string "title", default: "無題", null: false
    t.text "detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_illustrations_on_end_user_id"
    t.index ["theme_id"], name: "index_illustrations_on_theme_id"
  end

  create_table "theme_comments", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "theme_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_theme_comments_on_end_user_id"
    t.index ["theme_id"], name: "index_theme_comments_on_theme_id"
  end

  create_table "theme_tag_middles", force: :cascade do |t|
    t.integer "theme_id", null: false
    t.integer "theme_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theme_id"], name: "index_theme_tag_middles_on_theme_id"
    t.index ["theme_tag_id"], name: "index_theme_tag_middles_on_theme_tag_id"
  end

  create_table "theme_tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "themes", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.string "title", default: "無題", null: false
    t.text "detail"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "end_users"
  add_foreign_key "bookmarks", "illustrations"
  add_foreign_key "challenge_themes", "end_users"
  add_foreign_key "challenge_themes", "themes"
  add_foreign_key "favorites", "end_users"
  add_foreign_key "favorites", "illustrations"
  add_foreign_key "illustration_comments", "end_users"
  add_foreign_key "illustration_comments", "illustrations"
  add_foreign_key "illustration_tag_middles", "illustration_tags"
  add_foreign_key "illustration_tag_middles", "illustrations"
  add_foreign_key "illustrations", "end_users"
  add_foreign_key "illustrations", "themes"
  add_foreign_key "theme_comments", "end_users"
  add_foreign_key "theme_comments", "themes"
  add_foreign_key "theme_tag_middles", "theme_tags"
  add_foreign_key "theme_tag_middles", "themes"
end

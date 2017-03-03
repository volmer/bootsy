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

ActiveRecord::Schema.define(version: 20120710181942) do

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "author"
    t.text     "content"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

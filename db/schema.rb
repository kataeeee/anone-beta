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

ActiveRecord::Schema.define(version: 2018_12_15_120536) do

  create_table "basics", force: :cascade do |t|
    t.integer "user_id"
    t.integer "q1_sex"
    t.integer "q2_sexual_orientation"
    t.integer "q3_gender"
    t.integer "q4_partner"
    t.integer "q5_sexual_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "q6_gender_fitting"
    t.integer "q7_body_fitting"
    t.integer "q8_favorite_dress"
    t.integer "q9_choose_middle"
    t.integer "q10_personal_time"
    t.integer "q11_sensibility"
    t.integer "q12_behavior_adjusting"
    t.integer "q13_group_comfort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender_result"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

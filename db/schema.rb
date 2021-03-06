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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140418051104) do

  create_table "adminuser_logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "admin_user_id"
    t.datetime "sign_in_time"
    t.datetime "sign_out_time"
    t.string   "ip_address"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "fullname"
    t.string   "email"
    t.string   "sign_in_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "department"
  end

  create_table "core_values", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "setting_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "engage_users", :force => true do |t|
    t.integer  "voter_id"
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.integer  "vote_count"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "likes", :force => true do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
    t.integer  "count",         :default => 0, :null => false
  end

  add_index "likes", ["likeable_id", "likeable_type"], :name => "fk_likeables"
  add_index "likes", ["liker_id", "liker_type"], :name => "fk_likes"

  create_table "nominees", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "username"
    t.string   "email"
    t.string   "fullname"
    t.integer  "vote_setting_id"
    t.datetime "start_cycle"
    t.datetime "end_cycle"
    t.boolean  "status"
    t.integer  "current_user_id"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "admin_user_id"
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "plan_id"
    t.string   "status"
    t.string   "transasction_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "paypal_payments", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.string   "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.text     "forusers"
    t.text     "foradmins"
    t.text     "pricing"
  end

  create_table "product_manager_logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "admin_user_id"
    t.datetime "sign_in_time"
    t.datetime "sign_out_time"
    t.string   "ip_address"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "fullname"
    t.string   "email"
    t.string   "sign_in_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "prop_counts", :force => true do |t|
    t.integer  "receiver_id"
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.integer  "prop_count"
    t.integer  "points"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "prop_cycles", :force => true do |t|
    t.datetime "start_cycle"
    t.datetime "end_cycle"
    t.integer  "user_id"
    t.integer  "prop_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "prop_displays", :force => true do |t|
    t.integer  "points"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "description"
    t.string   "type_cycle"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "admin_user_id"
    t.date     "cycle_start_date"
    t.date     "cycle_end_date"
    t.integer  "prop_setting_id"
  end

  create_table "prop_results", :force => true do |t|
    t.integer  "receiver_id"
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.integer  "prop_count"
    t.integer  "points"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "props", :force => true do |t|
    t.boolean  "enable"
    t.boolean  "assign_points"
    t.integer  "start_point"
    t.integer  "end_point"
    t.integer  "step_point"
    t.string   "reset_point"
    t.integer  "user_id"
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.string   "subject2"
    t.text     "body2"
    t.string   "subject3"
    t.text     "body3"
    t.text     "intro"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "reminder1_days"
    t.integer  "reminder2_days"
    t.integer  "reminder3_days"
  end

  create_table "results", :force => true do |t|
    t.integer  "voteable_id"
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.integer  "vote_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "settings", :force => true do |t|
    t.string   "company_name"
    t.string   "website_address"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
    t.integer  "core_value_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "subscription_histories", :force => true do |t|
    t.string   "email"
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "paypal_payment_token"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
    t.string   "token"
    t.float    "price"
    t.string   "fullname"
    t.string   "name"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "subscription_id"
    t.date     "startdate"
    t.date     "enddate"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "email"
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "paypal_payment_token"
    t.string   "paypal_customer_token"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "paypal_recurring_profile_token"
    t.string   "token"
    t.string   "price"
    t.date     "date"
    t.string   "total_amount"
    t.string   "fullname"
    t.string   "name"
    t.date     "subscription_startdate"
    t.date     "subscription_enddate"
  end

  create_table "trial_days", :force => true do |t|
    t.integer  "days"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "plan_id"
    t.string   "plan_type"
    t.string   "companyname"
    t.string   "hear_aboutus"
    t.integer  "sign_in_count",          :default => 1
    t.datetime "last_sign_in"
    t.datetime "last_sign_out"
    t.integer  "admin_user_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "time_zone",              :default => "UTC"
    t.boolean  "status",                 :default => true
    t.string   "fullname"
    t.string   "department"
    t.boolean  "is_prop"
    t.boolean  "is_prop_reminder"
    t.boolean  "is_vote_reminder"
    t.string   "plan_name"
    t.boolean  "agree"
  end

  create_table "vote_counts", :force => true do |t|
    t.integer  "voteable_id"
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.integer  "vote_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "vote_cycles", :force => true do |t|
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.integer  "user_id"
    t.integer  "vote_setting_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "award_program_name"
  end

  create_table "vote_other_counts", :force => true do |t|
    t.integer  "voteable_id"
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.integer  "vote_count"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "vote_settings", :force => true do |t|
    t.string   "award_program_name"
    t.string   "award_frequency_type"
    t.date     "start_cycle"
    t.date     "end_cycle"
    t.text     "intro_text"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "user_id"
    t.string   "email_sender_name"
    t.string   "email_sender_email"
    t.string   "email_sender_subject1"
    t.text     "email_sender_body1"
    t.string   "email_sender_subject2"
    t.text     "email_sender_body2"
    t.string   "email_sender_subject3"
    t.text     "email_sender_body3"
    t.boolean  "is_autopick_winner"
    t.boolean  "is_admin_reminder"
    t.boolean  "is_allow_vote"
    t.integer  "reminder1_days"
    t.integer  "reminder2_days"
    t.integer  "reminder3_days"
  end

  create_table "votes", :force => true do |t|
    t.integer  "voter_id"
    t.integer  "voteable_id"
    t.text     "description"
    t.string   "core_values"
    t.date     "cycle_end_date"
    t.date     "cycle_start_date"
    t.integer  "vote_setting_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end

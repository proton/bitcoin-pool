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

ActiveRecord::Schema.define(:version => 20110603145507) do

  create_table "blocks", :force => true do |t|
    t.integer  "number"
    t.string   "checksum",                                                      :null => false
    t.datetime "found_at",                                                      :null => false
    t.decimal  "generated",     :precision => 16, :scale => 8, :default => 0.0, :null => false
    t.integer  "share_id"
    t.integer  "confirmations",                                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pps"
  end

  add_index "blocks", ["checksum"], :name => "checksum_idx", :unique => true

  create_table "contributions", :force => true do |t|
    t.integer  "block_id"
    t.integer  "worker_id"
    t.decimal  "score",       :precision => 16, :scale => 8, :default => 0.0, :null => false
    t.boolean  "found_block"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shares", :force => true do |t|
    t.text      "rem_host",        :null => false
    t.text      "username",        :null => false
    t.text      "our_result"
    t.text      "upstream_result"
    t.text      "reason"
    t.text      "solution"
    t.timestamp "created_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nick"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workers", :force => true do |t|
    t.string   "username",   :limit => 128, :null => false
    t.string   "password",   :limit => 128, :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pps"
  end

end

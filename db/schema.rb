# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090713035953) do

  create_table "namespaces", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "title",         :default => "article", :null => false
    t.integer  "alias_for_id"
    t.boolean  "interwiki",     :default => false,     :null => false
    t.string   "interwiki_url"
    t.integer  "talk_for_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_links", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.integer  "link_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name",                :null => false
    t.integer  "namespace_id",        :null => false
    t.integer  "current_revision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revisions", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.integer  "user_id",    :null => false
    t.text     "content",    :null => false
    t.text     "html"
    t.string   "changes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password",        :null => false
    t.string   "last_ip_address", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

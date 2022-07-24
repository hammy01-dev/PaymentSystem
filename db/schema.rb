
ActiveRecord::Schema.define(version: 2022_07_21_082800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "features", force: :cascade do |t|
    t.integer "max_unit_limit", null: false
    t.integer "unit_price", null: false
    t.string "name", null: false
    t.integer "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "plan_id"
    t.index ["plan_id"], name: "index_features_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.integer "monthly_fee", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "billing_date", default: -> { "CURRENT_DATE" }
    t.bigint "user_id"
    t.bigint "plan_id"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subscription_id"
    t.index ["subscription_id"], name: "index_transactions_on_subscription_id"
  end

  create_table "usages", force: :cascade do |t|
    t.integer "usage", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subscription_id"
    t.bigint "feature_id"
    t.index ["feature_id"], name: "index_usages_on_feature_id"
    t.index ["subscription_id"], name: "index_usages_on_subscription_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 1
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "features", "plans"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "transactions", "subscriptions"
  add_foreign_key "usages", "features"
  add_foreign_key "usages", "subscriptions"
end

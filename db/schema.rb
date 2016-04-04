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

ActiveRecord::Schema.define(version: 20151021060733) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "affiliates_users", force: :cascade do |t|
    t.integer "affiliate_id", limit: 4
    t.integer "user_id",      limit: 4
  end

  add_index "affiliates_users", ["affiliate_id", "user_id"], name: "index_affiliates_users_on_affiliate_id_and_user_id", using: :btree
  add_index "affiliates_users", ["user_id", "affiliate_id"], name: "index_affiliates_users_on_user_id_and_affiliate_id", using: :btree

  create_table "allergies", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "allergies_users", force: :cascade do |t|
    t.integer "allergy_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  add_index "allergies_users", ["allergy_id", "user_id"], name: "index_allergies_users_on_allergy_id_and_user_id", using: :btree
  add_index "allergies_users", ["user_id", "allergy_id"], name: "index_allergies_users_on_user_id_and_allergy_id", using: :btree

  create_table "avatars", force: :cascade do |t|
    t.string   "filename",   limit: 255
    t.string   "format",     limit: 255
    t.integer  "size",       limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "care_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "care_types_contracts", force: :cascade do |t|
    t.integer "care_type_id", limit: 4
    t.integer "contract_id",  limit: 4
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "owner_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "headline",        limit: 255
    t.text     "description",     limit: 65535
    t.integer  "hours_needed",    limit: 3
    t.integer  "job_type",        limit: 1
    t.integer  "required_rate",   limit: 3
    t.float    "latitude",        limit: 24
    t.float    "longitude",       limit: 24
    t.string   "zipcode",         limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.string   "patient_name",    limit: 255
    t.string   "phone",           limit: 255
    t.boolean  "indexable",       limit: 1,     default: false
    t.integer  "schedule_type",   limit: 4
    t.boolean  "schedule_need",   limit: 1
    t.integer  "gender",          limit: 4
    t.integer  "age_range",       limit: 4
    t.string   "hourly_type",     limit: 255
    t.boolean  "has_been_edited", limit: 1,     default: false
    t.integer  "care_type",       limit: 4
    t.date     "expected_date"
    t.integer  "days_of_care",    limit: 4
    t.integer  "time_of_care",    limit: 4
    t.integer  "language",        limit: 4
  end

  add_index "contracts", ["owner_id"], name: "index_contracts_on_owner_id", using: :btree

  create_table "contracts_requirements", force: :cascade do |t|
    t.integer "contract_id",    limit: 4
    t.integer "requirement_id", limit: 4
  end

  create_table "contracts_services", force: :cascade do |t|
    t.integer "contract_id", limit: 4
    t.integer "service_id",  limit: 4
  end

  add_index "contracts_services", ["contract_id", "service_id"], name: "index_contracts_services_on_contract_id_and_service_id", using: :btree
  add_index "contracts_services", ["service_id", "contract_id"], name: "index_contracts_services_on_service_id_and_contract_id", using: :btree

  create_table "contracts_users", force: :cascade do |t|
    t.integer "caregiver_id", limit: 4
    t.integer "contract_id",  limit: 4
  end

  add_index "contracts_users", ["contract_id", "caregiver_id"], name: "index_contracts_users_on_contract_id_and_caregiver_id", using: :btree

  create_table "cover_letters", force: :cascade do |t|
    t.integer  "caregiver_id", limit: 4
    t.text     "body",         limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "credentials", force: :cascade do |t|
    t.boolean  "HHA",        limit: 1,   default: false
    t.boolean  "LVN",        limit: 1,   default: false
    t.boolean  "CNA",        limit: 1,   default: false
    t.boolean  "RN",         limit: 1,   default: false
    t.string   "HHANumber",  limit: 255
    t.string   "LVNNumber",  limit: 255
    t.string   "CNANumber",  limit: 255
    t.string   "RNNumber",   limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "other",      limit: 1,   default: false
    t.boolean  "CPR",        limit: 1,   default: false
    t.string   "CPRNumber",  limit: 255
  end

  add_index "credentials", ["user_id"], name: "index_credentials_on_user_id", using: :btree

  create_table "crop_data", force: :cascade do |t|
    t.integer "crop_x",  limit: 4
    t.integer "crop_y",  limit: 4
    t.integer "crop_w",  limit: 4
    t.integer "crop_h",  limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "crop_data", ["user_id"], name: "index_crop_data_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.text    "employer",    limit: 65535
    t.date    "start_date"
    t.date    "finish_date"
    t.integer "user_id",     limit: 4
    t.text    "description", limit: 65535
    t.string  "position",    limit: 255
    t.boolean "current",     limit: 1
  end

  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "facebook_user_infos", force: :cascade do |t|
    t.integer  "user_id",          limit: 4,   null: false
    t.integer  "facebook_user_id", limit: 4,   null: false
    t.string   "username",         limit: 255, null: false
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "email",            limit: 255
    t.string   "gender",           limit: 255
    t.string   "name",             limit: 255
    t.string   "link",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_user_infos", ["facebook_user_id"], name: "index_facebook_user_infos_on_facebook_user_id", unique: true, using: :btree
  add_index "facebook_user_infos", ["user_id"], name: "index_facebook_user_infos_on_user_id", unique: true, using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "headline",   limit: 255
    t.string   "body",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "languages", primary_key: "code", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "languages_users", force: :cascade do |t|
    t.integer "user_id",       limit: 4
    t.string  "language_code", limit: 2
  end

  add_index "languages_users", ["language_code", "user_id"], name: "index_languages_users_on_language_code_and_user_id", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id",   limit: 4
    t.string  "unsubscriber_type", limit: 255
    t.integer "conversation_id",   limit: 4
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    limit: 255, default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type",                 limit: 255
    t.text     "body",                 limit: 65535
    t.string   "subject",              limit: 255,   default: ""
    t.integer  "sender_id",            limit: 4
    t.string   "sender_type",          limit: 255
    t.integer  "conversation_id",      limit: 4
    t.boolean  "draft",                limit: 1,     default: false
    t.datetime "updated_at",                                         null: false
    t.datetime "created_at",                                         null: false
    t.integer  "notified_object_id",   limit: 4
    t.string   "notified_object_type", limit: 255
    t.string   "notification_code",    limit: 255
    t.string   "attachment",           limit: 255
    t.boolean  "global",               limit: 1,     default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id",     limit: 4
    t.string   "receiver_type",   limit: 255
    t.integer  "notification_id", limit: 4,                   null: false
    t.boolean  "is_read",         limit: 1,   default: false
    t.boolean  "trashed",         limit: 1,   default: false
    t.boolean  "deleted",         limit: 1,   default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "offers", force: :cascade do |t|
    t.integer  "caregiver_id",    limit: 4
    t.integer  "contract_id",     limit: 4
    t.integer  "rate",            limit: 3
    t.integer  "status",          limit: 4, default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contract_type",   limit: 2
    t.integer  "conversation_id", limit: 4
  end

  add_index "offers", ["caregiver_id"], name: "index_offers_on_caregiver_id", using: :btree
  add_index "offers", ["contract_id"], name: "index_offers_on_contract_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.string  "q1",      limit: 255
    t.string  "q2",      limit: 255
    t.string  "q3",      limit: 255
    t.string  "q4",      limit: 255
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "references", force: :cascade do |t|
    t.text     "body",                 limit: 65535
    t.integer  "user_id",              limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "caregiver_id",         limit: 4
    t.integer  "relationship",         limit: 1
    t.string   "name",                 limit: 255
    t.integer  "dependability",        limit: 4
    t.integer  "technical_ability",    limit: 4
    t.integer  "communication_skills", limit: 4
    t.integer  "compassion",           limit: 4
  end

  add_index "references", ["user_id"], name: "index_references_on_user_id", using: :btree

  create_table "requested_references", force: :cascade do |t|
    t.text    "name",         limit: 65535
    t.text    "phone",        limit: 65535
    t.text    "email",        limit: 65535
    t.integer "caregiver_id", limit: 4
  end

  create_table "requirements", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: :cascade do |t|
    t.boolean "monday_morning",          limit: 1, default: false
    t.boolean "monday_afternoon",        limit: 1
    t.boolean "monday_mid_afternoon",    limit: 1, default: false
    t.boolean "monday_evening",          limit: 1, default: false
    t.boolean "monday_overnight",        limit: 1, default: false
    t.boolean "tuesday_morning",         limit: 1, default: false
    t.boolean "tuesday_afternoon",       limit: 1, default: false
    t.boolean "tuesday_mid_afternoon",   limit: 1, default: false
    t.boolean "tuesday_evening",         limit: 1, default: false
    t.boolean "tuesday_overnight",       limit: 1, default: false
    t.boolean "wednesday_morning",       limit: 1, default: false
    t.boolean "wednesday_afternoon",     limit: 1, default: false
    t.boolean "wednesday_mid_afternoon", limit: 1, default: false
    t.boolean "wednesday_evening",       limit: 1, default: false
    t.boolean "wednesday_overnight",     limit: 1, default: false
    t.boolean "thursday_morning",        limit: 1, default: false
    t.boolean "thursday_afternoon",      limit: 1, default: false
    t.boolean "thursday_mid_afternoon",  limit: 1, default: false
    t.boolean "thursday_evening",        limit: 1, default: false
    t.boolean "thursday_overnight",      limit: 1, default: false
    t.boolean "friday_morning",          limit: 1, default: false
    t.boolean "friday_afternoon",        limit: 1, default: false
    t.boolean "friday_mid_afternoon",    limit: 1, default: false
    t.boolean "friday_evening",          limit: 1, default: false
    t.boolean "friday_overnight",        limit: 1, default: false
    t.boolean "saturday_morning",        limit: 1, default: false
    t.boolean "saturday_afternoon",      limit: 1, default: false
    t.boolean "saturday_mid_afternoon",  limit: 1, default: false
    t.boolean "saturday_evening",        limit: 1, default: false
    t.boolean "saturday_overnight",      limit: 1, default: false
    t.boolean "sunday_morning",          limit: 1, default: false
    t.boolean "sunday_afternoon",        limit: 1, default: false
    t.boolean "sunday_mid_afternoon",    limit: 1, default: false
    t.boolean "sunday_evening",          limit: 1, default: false
    t.boolean "sunday_overnight",        limit: 1, default: false
    t.integer "user_id",                 limit: 4
    t.integer "contract_id",             limit: 4
  end

  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.text    "name",             limit: 65535
    t.integer "degree",           limit: 1
    t.integer "user_id",          limit: 4
    t.text    "description",      limit: 65535
    t.integer "start_date_year",  limit: 4
    t.integer "finish_date_year", limit: 4
  end

  add_index "schools", ["user_id"], name: "index_schools_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "type", limit: 255
  end

  create_table "services_users", force: :cascade do |t|
    t.integer "service_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  add_index "services_users", ["service_id", "user_id"], name: "index_services_users_on_service_id_and_user_id", using: :btree
  add_index "services_users", ["user_id", "service_id"], name: "index_services_users_on_user_id_and_service_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "tag_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "trainings", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.date     "start_date"
    t.date     "finish_date"
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     limit: 4
  end

  add_index "trainings", ["user_id"], name: "index_trainings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",     null: false
    t.string   "encrypted_password",     limit: 255,   default: "",     null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zipcode",                limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "gender",                 limit: 4
    t.text     "bio",                    limit: 65535
    t.string   "headline",               limit: 255
    t.string   "hours",                  limit: 255,   default: "0"
    t.integer  "work_experience",        limit: 4
    t.integer  "availability",           limit: 4
    t.boolean  "insured",                limit: 1
    t.boolean  "bonded",                 limit: 1
    t.boolean  "background_checked",     limit: 1
    t.boolean  "reviewed",               limit: 1
    t.float    "latitude",               limit: 24
    t.float    "longitude",              limit: 24
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.integer  "hourly_rate",            limit: 4
    t.integer  "references_count",       limit: 4,     default: 0
    t.boolean  "private",                limit: 1
    t.string   "facebook_id",            limit: 255
    t.string   "type",                   limit: 255,   default: "User"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "phone",                  limit: 255
    t.integer  "transportation",         limit: 4
    t.date     "date_of_birth"
    t.string   "employer",               limit: 255
    t.integer  "pets",                   limit: 1
    t.boolean  "avatar_processing",      limit: 1
    t.boolean  "hospice",                limit: 1,     default: false
    t.boolean  "indexable",              limit: 1,     default: false
    t.integer  "smokes",                 limit: 1
    t.string   "md5hash",                limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "customer_id",            limit: 255
    t.boolean  "contacted",              limit: 1,     default: false
    t.string   "carrier",                limit: 255
    t.text     "question_1",             limit: 65535
    t.text     "question_2",             limit: 65535
    t.text     "question_3",             limit: 65535
    t.text     "question_4",             limit: 65535
    t.string   "background",             limit: 255
    t.boolean  "live_in",                limit: 1
    t.text     "hometown",               limit: 65535
    t.integer  "live_in_rate",           limit: 4
    t.boolean  "edit_profile_modal",     limit: 1,     default: false
    t.boolean  "congrats_modal",         limit: 1,     default: false
    t.string   "referral_code",          limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", unique: true, using: :btree
  add_index "users", ["id", "type"], name: "index_users_on_id_and_type", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

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

ActiveRecord::Schema.define(version: 20170731153719) do

  create_table "alternatives", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "question_id",                                 null: false, unsigned: true
    t.string  "label",         limit: 1,                     null: false
    t.text    "content",       limit: 65535,                 null: false
    t.text    "justification", limit: 65535,                 null: false
    t.boolean "correct",                     default: false, null: false
    t.index ["label", "question_id"], name: "label_UNIQUE", unique: true, using: :btree
    t.index ["question_id"], name: "fk_alternatives_questions1_idx", using: :btree
  end

  create_table "answers", primary_key: ["alternative_id", "candidate_id"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "alternative_id", null: false, unsigned: true
    t.integer "candidate_id",   null: false, unsigned: true
    t.index ["alternative_id"], name: "fk_alternatives_has_candidates_alternatives1_idx", using: :btree
    t.index ["candidate_id"], name: "fk_answers_candidates1_idx", using: :btree
  end

  create_table "areas", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",       limit: 64, null: false
    t.string "short_name", limit: 64, null: false
  end

  create_table "candidates", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "exam_id",                                                                            null: false, unsigned: true
    t.integer "school_id",                                                                                       unsigned: true
    t.integer "city_id",                                                                                         unsigned: true
    t.bigint  "registration",                                                                       null: false, unsigned: true
    t.string  "presence",                limit: 10,                                                 null: false
    t.string  "consistency",             limit: 11,                         default: "unavailable", null: false
    t.integer "age",                     limit: 1,                                                               unsigned: true
    t.string  "nationality",             limit: 11
    t.string  "gender",                  limit: 6
    t.string  "conclusion",              limit: 10
    t.integer "conclusion_year",         limit: 2,                                                               unsigned: true
    t.string  "school_type",             limit: 7
    t.string  "conclusion_type",         limit: 12
    t.string  "marital_status",          limit: 8
    t.string  "color",                   limit: 8
    t.string  "lc_type",                 limit: 7
    t.string  "essay_status",            limit: 12
    t.decimal "first_competence_score",             precision: 5, scale: 1
    t.decimal "second_competence_score",            precision: 5, scale: 1
    t.decimal "third_competence_score",             precision: 5, scale: 1
    t.decimal "fourth_competence_score",            precision: 5, scale: 1
    t.decimal "fifth_competence_score",             precision: 5, scale: 1
    t.decimal "essay_score",                        precision: 5, scale: 1
    t.index ["city_id"], name: "fk_candidates_cities1_idx", using: :btree
    t.index ["exam_id"], name: "fk_candidates_exams1_idx", using: :btree
    t.index ["registration"], name: "registration_UNIQUE", unique: true, using: :btree
    t.index ["school_id"], name: "fk_candidates_schools1_idx", using: :btree
  end

  create_table "cities", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "state_id",              null: false, unsigned: true
    t.integer "ibge_code",             null: false, unsigned: true
    t.string  "name",      limit: 128, null: false
    t.index ["ibge_code"], name: "ibge_code_UNIQUE", unique: true, using: :btree
    t.index ["state_id"], name: "fk_cities_states1_idx", using: :btree
  end

  create_table "exams", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "year",           limit: 2,     null: false, unsigned: true
    t.text    "essay_proposal", limit: 65535, null: false
  end

  create_table "frequencies", primary_key: ["school_id", "exam_id", "question_id", "alternative_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "school_id",                  null: false, unsigned: true
    t.integer "exam_id",                    null: false, unsigned: true
    t.integer "question_id",                null: false, unsigned: true
    t.integer "alternative_id",             null: false, unsigned: true
    t.integer "frequency",      default: 0, null: false, unsigned: true
    t.index ["alternative_id"], name: "fk_frequencies_alternatives1_idx", using: :btree
    t.index ["exam_id"], name: "fk_frequencies_exams1_idx", using: :btree
    t.index ["question_id"], name: "fk_frequencies_questions1_idx", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_groups_on_user_id", using: :btree
  end

  create_table "groups_schools", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "group_id",  null: false
    t.integer "school_id", null: false
  end

  create_table "origins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",                    null: false
    t.string "public_key", limit: 4096
    t.index ["name"], name: "index_origins_on_name", unique: true, using: :btree
  end

  create_table "questions", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "skill_id",                 null: false, unsigned: true
    t.integer "exam_id",                  null: false, unsigned: true
    t.integer "subject_id",               null: false, unsigned: true
    t.integer "position",                 null: false, unsigned: true
    t.string  "label",      limit: 4,     null: false
    t.text    "content",    limit: 65535, null: false
    t.index ["exam_id"], name: "fk_questions_exams1_idx", using: :btree
    t.index ["skill_id"], name: "fk_questions_skills1_idx", using: :btree
    t.index ["subject_id"], name: "fk_questions_subjects1_idx", using: :btree
  end

  create_table "rawdata", primary_key: "registration", id: :bigint, default: nil, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "year",                    limit: 2,                                                   null: false, unsigned: true
    t.string  "consistency",             limit: 11,                          default: "unavailable", null: false
    t.integer "resident_city_code",      limit: 3,                                                                unsigned: true
    t.string  "resident_city_name",      limit: 150
    t.integer "resident_state_code",     limit: 1,                                                                unsigned: true
    t.string  "resident_state_name",     limit: 2
    t.boolean "hospital_unity"
    t.boolean "training"
    t.integer "school_code",                                                                                      unsigned: true
    t.integer "school_city_code",        limit: 3,                                                                unsigned: true
    t.string  "school_city_name",        limit: 150
    t.integer "school_state_code",       limit: 1,                                                                unsigned: true
    t.string  "school_state_name",       limit: 2
    t.string  "school_dependency",       limit: 7
    t.string  "school_location",         limit: 5
    t.string  "school_status",           limit: 8
    t.integer "age",                     limit: 1,                                                                unsigned: true
    t.string  "gender",                  limit: 6
    t.string  "nationality",             limit: 11
    t.integer "birth_city_code",         limit: 3,                                                                unsigned: true
    t.string  "birth_city_name",         limit: 150
    t.integer "birth_state_code",        limit: 1,                                                                unsigned: true
    t.string  "birth_state_name",        limit: 2
    t.string  "conclusion",              limit: 10
    t.integer "conclusion_year",         limit: 2,                                                                unsigned: true
    t.string  "school_type",             limit: 7
    t.string  "conclusion_type",         limit: 12
    t.string  "marital_status",          limit: 8
    t.string  "color",                   limit: 8
    t.boolean "low_vision"
    t.boolean "blind"
    t.boolean "deaf"
    t.boolean "hearing_deficiency"
    t.boolean "blind_deaf"
    t.boolean "physical_disability"
    t.boolean "mental_disability"
    t.boolean "attention_deficit"
    t.boolean "dyslexia"
    t.boolean "pregnancy"
    t.boolean "lactating"
    t.boolean "elderly"
    t.boolean "dyscalculia"
    t.boolean "autism"
    t.boolean "monocular_vision"
    t.boolean "sabbatista"
    t.boolean "other_deficiency"
    t.boolean "resource"
    t.boolean "social_name"
    t.boolean "braille"
    t.boolean "enlarged_big"
    t.boolean "enlarged_medium"
    t.boolean "reader"
    t.boolean "easy_access"
    t.boolean "transcription"
    t.boolean "hand_talk"
    t.boolean "lip_reading"
    t.boolean "wheelchair"
    t.boolean "separated_chair"
    t.boolean "leg_support"
    t.boolean "interpret_guide"
    t.boolean "litter"
    t.boolean "computer"
    t.boolean "special_chair"
    t.boolean "left_handed_chair"
    t.boolean "padded_chair"
    t.boolean "lying"
    t.boolean "obese_furniture"
    t.boolean "overlay_blade"
    t.boolean "hearing_protector"
    t.boolean "glucose_meter"
    t.boolean "braille_machine"
    t.boolean "soroban"
    t.boolean "pacemaker"
    t.boolean "probe"
    t.boolean "medicine"
    t.boolean "individual_room"
    t.boolean "special_room"
    t.boolean "companion_room"
    t.boolean "specific_forniture"
    t.boolean "specific_material"
    t.boolean "other_necessity"
    t.boolean "prison_unity"
    t.boolean "certification"
    t.string  "certifier_name",          limit: 150
    t.integer "certifier_state_code",    limit: 1,                                                                unsigned: true
    t.string  "certifier_state_name",    limit: 2
    t.integer "test_city_code",          limit: 3,                                                                unsigned: true
    t.string  "test_city_name",          limit: 150
    t.integer "test_state_code",         limit: 1,                                                                unsigned: true
    t.string  "test_state_name",         limit: 2
    t.string  "cn_presence",             limit: 10
    t.string  "ch_presence",             limit: 10
    t.string  "lc_presence",             limit: 10
    t.string  "mt_presence",             limit: 10
    t.integer "cn_test_code",            limit: 2,                                                                unsigned: true
    t.integer "ch_test_code",            limit: 2,                                                                unsigned: true
    t.integer "lc_test_code",            limit: 2,                                                                unsigned: true
    t.integer "mt_test_code",            limit: 2,                                                                unsigned: true
    t.decimal "cn_score",                            precision: 5, scale: 1
    t.decimal "ch_score",                            precision: 5, scale: 1
    t.decimal "lc_score",                            precision: 5, scale: 1
    t.decimal "mt_score",                            precision: 5, scale: 1
    t.string  "cn_answers",              limit: 45
    t.string  "ch_answers",              limit: 45
    t.string  "lc_answers",              limit: 45
    t.string  "mt_answers",              limit: 45
    t.string  "lc_type",                 limit: 7
    t.string  "cn_key",                  limit: 45
    t.string  "ch_key",                  limit: 45
    t.string  "lc_key",                  limit: 45
    t.string  "mt_key",                  limit: 45
    t.string  "essay_status",            limit: 12
    t.decimal "first_competence_score",              precision: 5, scale: 1
    t.decimal "second_competence_score",             precision: 5, scale: 1
    t.decimal "third_competence_score",              precision: 5, scale: 1
    t.decimal "fourth_competence_score",             precision: 5, scale: 1
    t.decimal "fifth_competence_score",              precision: 5, scale: 1
    t.decimal "essay_score",                         precision: 5, scale: 1
    t.index ["ch_test_code"], name: "ch_test_code_index1", using: :btree
    t.index ["cn_test_code"], name: "cn_test_code_index1", using: :btree
    t.index ["lc_test_code", "lc_type"], name: "lc_test_code_index1", using: :btree
    t.index ["mt_test_code"], name: "mt_test_code_index1", using: :btree
    t.index ["school_code"], name: "school_code_index1", using: :btree
  end

  create_table "school_summary", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "school_id",              unsigned: true
    t.integer "exam_id",   null: false, unsigned: true
  end

  create_table "schools", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "city_id",                null: false, unsigned: true
    t.integer "inep_code",              null: false, unsigned: true
    t.string  "inep_name",  limit: 128, null: false
    t.string  "name",       limit: 128, null: false
    t.string  "dependency", limit: 7,   null: false
    t.string  "location",   limit: 5,   null: false
    t.string  "status",     limit: 8,   null: false
    t.index ["city_id"], name: "fk_schools_cities1_idx", using: :btree
    t.index ["inep_code"], name: "inep_code_UNIQUE", unique: true, using: :btree
  end

  create_table "schools_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "school_id", null: false
    t.integer "user_id",   null: false
    t.index ["school_id", "user_id"], name: "index_schools_users_on_school_id_and_user_id", using: :btree
    t.index ["user_id", "school_id"], name: "index_schools_users_on_user_id_and_school_id", using: :btree
  end

  create_table "scores", primary_key: ["area_id", "candidate_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "area_id",                                         null: false, unsigned: true
    t.integer "candidate_id",                                    null: false, unsigned: true
    t.string  "presence",     limit: 10,                         null: false
    t.decimal "score",                   precision: 5, scale: 1
    t.index ["area_id"], name: "fk_areas_has_candidate_areas1_idx", using: :btree
    t.index ["candidate_id"], name: "fk_statuses_candidates1_idx", using: :btree
  end

  create_table "skills", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "area_id",                               null: false, unsigned: true
    t.string  "label",       limit: 4,                 null: false
    t.string  "description", limit: 1024, default: "", null: false
    t.index ["area_id"], name: "fk_skills_areas1_idx", using: :btree
  end

  create_table "states", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "ibge_code",            null: false, unsigned: true
    t.string  "acronym",   limit: 2,  null: false
    t.string  "name",      limit: 64, null: false
    t.index ["ibge_code"], name: "ibge_code_UNIQUE", unique: true, using: :btree
  end

  create_table "subjects", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "area_id",            null: false, unsigned: true
    t.string  "name",    limit: 64, null: false
    t.index ["area_id"], name: "fk_subjects_areas1_idx", using: :btree
  end

  create_table "summaries", primary_key: ["school_id", "exam_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "school_id",                                           null: false, unsigned: true
    t.integer "exam_id",                                             null: false, unsigned: true
    t.decimal "ch_score",        precision: 5, scale: 1,             null: false
    t.decimal "cn_score",        precision: 5, scale: 1,             null: false
    t.decimal "lc_score",        precision: 5, scale: 1,             null: false
    t.decimal "mt_score",        precision: 5, scale: 1,             null: false
    t.decimal "general_score",   precision: 5, scale: 1,             null: false
    t.integer "city_ranking",                            default: 0, null: false
    t.integer "state_ranking",                           default: 0, null: false
    t.integer "country_ranking",                         default: 0, null: false
    t.index ["exam_id"], name: "fk_summaries_exams1_idx", using: :btree
  end

  create_table "taggings", primary_key: ["tag_id", "question_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tag_id",      null: false, unsigned: true
    t.integer "question_id", null: false, unsigned: true
    t.index ["question_id"], name: "fk_questions_has_tags_questions1_idx", using: :btree
    t.index ["tag_id"], name: "fk_questions_has_tags_tags1_idx", using: :btree
  end

  create_table "tags", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 128, null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider",                             default: "email", null: false
    t.string   "uid",                                  default: "",      null: false
    t.string   "encrypted_password",                   default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "email"
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "phone"
    t.integer  "origin_id"
    t.string   "role"
    t.boolean  "full_access",                          default: false,   null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["origin_id", "email"], name: "index_users_on_origin_id_and_email", unique: true, using: :btree
    t.index ["origin_id"], name: "index_users_on_origin_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider", "origin_id"], name: "index_users_on_uid_and_provider_and_origin_id", unique: true, using: :btree
  end

  add_foreign_key "candidates", "cities", name: "fk_candidates_cities1"
  add_foreign_key "candidates", "exams", name: "fk_candidates_exams1"
  add_foreign_key "candidates", "schools", name: "fk_candidates_schools1"
  add_foreign_key "cities", "states", name: "fk_cities_states1"
  add_foreign_key "frequencies", "alternatives", name: "fk_frequencies_alternatives1"
  add_foreign_key "frequencies", "exams", name: "fk_frequencies_exams1"
  add_foreign_key "frequencies", "questions", name: "fk_frequencies_questions1"
  add_foreign_key "frequencies", "schools", name: "fk_frequencies_schools1"
  add_foreign_key "groups", "users"
  add_foreign_key "questions", "exams", name: "fk_questions_exams1"
  add_foreign_key "questions", "skills", name: "fk_questions_skills1"
  add_foreign_key "questions", "subjects", name: "fk_questions_subjects1"
  add_foreign_key "schools", "cities", name: "fk_schools_cities1"
  add_foreign_key "scores", "areas", name: "fk_areas_has_candidate_areas1"
  add_foreign_key "scores", "candidates", name: "fk_statuses_candidates1"
  add_foreign_key "skills", "areas", name: "fk_skills_areas1"
  add_foreign_key "subjects", "areas", name: "fk_subjects_areas1"
  add_foreign_key "summaries", "exams", name: "fk_summaries_exams1"
  add_foreign_key "summaries", "schools", name: "fk_summaries_schools1"
  add_foreign_key "taggings", "questions", name: "fk_questions_has_tags_questions1"
  add_foreign_key "taggings", "tags", name: "fk_questions_has_tags_tags1"
end

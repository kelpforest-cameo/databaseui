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

ActiveRecord::Schema.define(:version => 20130926042527) do

  create_table "author_cites", :force => true do |t|
    t.integer  "author_id",                      :null => false
    t.integer  "citation_id",                    :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "project_id",                     :null => false
    t.boolean  "mod",         :default => true
    t.boolean  "approved",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "authors", :force => true do |t|
    t.string   "first_name", :default => "",    :null => false
    t.string   "last_name",  :default => "",    :null => false
    t.integer  "user_id",                       :null => false
    t.integer  "project_id",                    :null => false
    t.boolean  "mod",        :default => true
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "citations", :force => true do |t|
    t.string   "title",        :default => "",    :null => false
    t.string   "document"
    t.integer  "year",                            :null => false
    t.text     "abstract"
    t.string   "format",       :default => "",    :null => false
    t.string   "format_title"
    t.string   "publisher"
    t.integer  "number"
    t.integer  "volume"
    t.string   "pages"
    t.boolean  "closed",       :default => false, :null => false
    t.integer  "user_id",                         :null => false
    t.integer  "project_id",                      :null => false
    t.boolean  "mod",          :default => true
    t.boolean  "approved",     :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "competition_interaction_observations", :force => true do |t|
    t.integer  "citation_id",                                   :null => false
    t.integer  "competition_interaction_id",                    :null => false
    t.integer  "location_id",                                   :null => false
    t.string   "observation_type",           :default => "",    :null => false
    t.string   "competition_type"
    t.text     "comment"
    t.string   "datum",                      :default => "",    :null => false
    t.integer  "user_id",                                       :null => false
    t.integer  "project_id",                                    :null => false
    t.boolean  "mod",                        :default => true
    t.boolean  "approved",                   :default => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "competition_interactions", :force => true do |t|
    t.integer  "stage_1_id",                    :null => false
    t.integer  "stage_2_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.integer  "project_id",                    :null => false
    t.boolean  "mod",        :default => true
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "facilitation_interaction_observations", :force => true do |t|
    t.integer  "citation_id",                                    :null => false
    t.integer  "facilitation_interaction_id",                    :null => false
    t.integer  "location_id",                                    :null => false
    t.string   "observation_type",            :default => "",    :null => false
    t.string   "facilitation_type"
    t.text     "comment"
    t.string   "datum",                       :default => "",    :null => false
    t.integer  "user_id",                                        :null => false
    t.integer  "project_id",                                     :null => false
    t.boolean  "mod",                         :default => true
    t.boolean  "approved",                    :default => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "facilitation_interactions", :force => true do |t|
    t.integer  "stage_1_id",                    :null => false
    t.integer  "stage_2_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.integer  "project_id",                    :null => false
    t.boolean  "mod",        :default => true
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "functional_groups", :force => true do |t|

    t.string   "name",       :default => "",    :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "project_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "mod",        :default => true,  :null => false
    t.boolean  "approved",   :default => false, :null => false
  end

  create_table "location_data", :force => true do |t|
    t.text    "latitude"
    t.text    "longitude"
    t.integer "location_id"
    t.string  "name"
  end

  create_table "locations", :force => true do |t|
    t.string   "name",       :default => "",   :null => false
    t.integer  "left",                         :null => false
    t.integer  "right",                        :null => false
    t.integer  "parent",                       :null => false
    t.boolean  "active",     :default => true
    t.boolean  "visible",    :default => true, :null => false
    t.integer  "zoom_min",   :default => -1,   :null => false
    t.integer  "zoom_max",   :default => 15,   :null => false
    t.integer  "z_index",    :default => 1,    :null => false
    t.integer  "user_id",                      :null => false
    t.integer  "project_id",                   :null => false
    t.boolean  "mod",        :default => true
    t.boolean  "approved"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "node_max_ages", :force => true do |t|
    t.integer  "citation_id",                                                    :null => false
    t.integer  "node_id",                                                        :null => false
    t.decimal  "max_age",     :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                       :default => "",    :null => false
    t.integer  "user_id",                                                        :null => false
    t.integer  "project_id",                                                     :null => false
    t.boolean  "mod",                                         :default => true
    t.boolean  "approved",                                    :default => false
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "node_ranges", :force => true do |t|
    t.integer  "citation_id",                      :null => false
    t.integer  "node_id",                          :null => false
    t.integer  "location_n_id",                    :null => false
    t.integer  "location_s_id",                    :null => false
    t.text     "comment"
    t.string   "datum",         :default => "",    :null => false
    t.integer  "user_id",                          :null => false
    t.integer  "project_id",                       :null => false
    t.boolean  "mod",           :default => true
    t.boolean  "approved",      :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "nodes", :force => true do |t|
    t.integer  "itis_id",                                :null => false
    t.integer  "non_itis_id",                            :null => false
    t.string   "working_name",        :default => "",    :null => false
    t.integer  "functional_group_id",                    :null => false
    t.string   "native_status"
    t.boolean  "is_assemblage",                          :null => false
    t.integer  "user_id",                                :null => false
    t.integer  "project_id",                             :null => false
    t.boolean  "mod",                 :default => true
    t.boolean  "approved",            :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "non_itis", :force => true do |t|
    t.integer  "parent_id",                            :null => false
    t.string   "latin_name",        :default => "",    :null => false
    t.string   "taxonomy_level",    :default => "",    :null => false
    t.boolean  "parent_id_is_itis",                    :null => false
    t.text     "info"
    t.integer  "user_id",                              :null => false
    t.integer  "project_id",                           :null => false
    t.boolean  "mod",               :default => true
    t.boolean  "approved",          :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "parasitic_interaction_observations", :force => true do |t|
    t.integer  "citation_id",                                                                 :null => false
    t.integer  "parasitic_interaction_id",                                                    :null => false
    t.integer  "location_id",                                                                 :null => false
    t.string   "endo_ecto"
    t.string   "lethality"
    t.decimal  "prevalence",               :precision => 64, :scale => 12
    t.decimal  "intensity",                :precision => 64, :scale => 12
    t.string   "parasite_type"
    t.string   "observation_type",                                         :default => "",    :null => false
    t.text     "comment"
    t.string   "datum",                                                    :default => "",    :null => false
    t.integer  "user_id",                                                                     :null => false
    t.integer  "project_id",                                                                  :null => false
    t.boolean  "mod",                                                      :default => true
    t.boolean  "approved",                                                 :default => false
    t.datetime "created_at",                                                                  :null => false
    t.datetime "updated_at",                                                                  :null => false
  end

  create_table "parasitic_interactions", :force => true do |t|
    t.integer  "stage_1_id",                    :null => false
    t.integer  "stage_2_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.integer  "project_id",                    :null => false
    t.boolean  "mod",        :default => true
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name",       :default => "",    :null => false
    t.integer  "owner",                         :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "public",     :default => false
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "stage_biomass_changes", :force => true do |t|
    t.integer  "citation_id",                                                       :null => false
    t.integer  "stage_id",                                                          :null => false
    t.decimal  "biomass_change", :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                          :default => "",    :null => false
    t.integer  "user_id",                                                           :null => false
    t.integer  "project_id",                                                        :null => false
    t.boolean  "mod",                                            :default => true
    t.boolean  "approved",                                       :default => false
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  create_table "stage_biomass_densities", :force => true do |t|
    t.integer  "citation_id",                                                        :null => false
    t.integer  "stage_id",                                                           :null => false
    t.decimal  "biomass_density", :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                           :default => "",    :null => false
    t.integer  "user_id",                                                            :null => false
    t.integer  "project_id",                                                         :null => false
    t.boolean  "mod",                                             :default => true
    t.boolean  "approved",                                        :default => false
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  create_table "stage_consum_biomass_ratios", :force => true do |t|
    t.integer  "citation_id",                                                             :null => false
    t.integer  "stage_id",                                                                :null => false
    t.decimal  "consum_biomass_ratio", :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                                :default => "",    :null => false
    t.integer  "user_id",                                                                 :null => false
    t.integer  "project_id",                                                              :null => false
    t.boolean  "mod",                                                  :default => true
    t.boolean  "approved",                                             :default => false
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
  end

  create_table "stage_consumer_strategies", :force => true do |t|
    t.integer  "citation_id",                                :null => false
    t.integer  "stage_id",                                   :null => false
    t.string   "consumer_strategy", :default => "autotroph", :null => false
    t.text     "comment"
    t.string   "datum",             :default => "",          :null => false
    t.integer  "user_id",                                    :null => false
    t.integer  "project_id",                                 :null => false
    t.boolean  "mod",               :default => true
    t.boolean  "approved",          :default => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "stage_drymasses", :force => true do |t|
    t.integer  "citation_id",                                                    :null => false
    t.integer  "stage_id",                                                       :null => false
    t.decimal  "drymass",     :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                       :default => "",    :null => false
    t.integer  "user_id",                                                        :null => false
    t.integer  "project_id",                                                     :null => false
    t.boolean  "mod",                                         :default => true
    t.boolean  "approved",                                    :default => false
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "stage_durations", :force => true do |t|
    t.integer  "citation_id",                                                    :null => false
    t.integer  "stage_id",                                                       :null => false
    t.decimal  "duration",    :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                       :default => "",    :null => false
    t.integer  "user_id",                                                        :null => false
    t.integer  "project_id",                                                     :null => false
    t.boolean  "mod",                                         :default => true
    t.boolean  "approved",                                    :default => false
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "stage_fecundities", :force => true do |t|
    t.integer  "citation_id",                    :null => false
    t.integer  "stage_id",                       :null => false
    t.string   "fecundity",   :default => "",    :null => false
    t.text     "comment"
    t.string   "datum",       :default => "",    :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "project_id",                     :null => false
    t.boolean  "mod",         :default => true
    t.boolean  "approved",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "stage_habitat_descriptors", :force => true do |t|
    t.string   "descriptor", :default => "",    :null => false
    t.integer  "user_id",                       :null => false
    t.integer  "project_id",                    :null => false
    t.boolean  "mod",        :default => true
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "stage_habitats", :force => true do |t|
    t.integer  "citation_id",                    :null => false
    t.integer  "stage_id",                       :null => false
    t.string   "habitat",     :default => "",    :null => false
    t.text     "comment"
    t.string   "datum",       :default => "",    :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "project_id",                     :null => false
    t.boolean  "mod",         :default => true
    t.boolean  "approved",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "stage_length_fecundities", :force => true do |t|
    t.integer  "citation_id",                                                                                      :null => false
    t.integer  "stage_id",                                                                                         :null => false
    t.string   "length_fecundity",                                 :default => "none exists - constant fecundity", :null => false
    t.decimal  "a",                :precision => 64, :scale => 12, :default => 0.0,                                :null => false
    t.decimal  "b",                :precision => 64, :scale => 12, :default => 0.0,                                :null => false
    t.text     "comment"
    t.string   "datum",                                            :default => "",                                 :null => false
    t.integer  "user_id",                                                                                          :null => false
    t.integer  "project_id",                                                                                       :null => false
    t.boolean  "mod",                                              :default => true
    t.boolean  "approved",                                         :default => false
    t.datetime "created_at",                                                                                       :null => false
    t.datetime "updated_at",                                                                                       :null => false
  end

  create_table "stage_length_weights", :force => true do |t|
    t.integer  "citation_id",                                                                                :null => false
    t.integer  "stage_id",                                                                                   :null => false
    t.string   "length_weight",                                 :default => "none exists - constant weight", :null => false
    t.decimal  "a",             :precision => 64, :scale => 12, :default => 0.0,                             :null => false
    t.decimal  "b",             :precision => 64, :scale => 12, :default => 0.0,                             :null => false
    t.text     "comment"
    t.string   "datum",                                         :default => "",                              :null => false
    t.integer  "user_id",                                                                                    :null => false
    t.integer  "project_id",                                                                                 :null => false
    t.boolean  "mod",                                           :default => true
    t.boolean  "approved",                                      :default => false
    t.datetime "created_at",                                                                                 :null => false
    t.datetime "updated_at",                                                                                 :null => false
  end

  create_table "stage_lengths", :force => true do |t|
    t.integer  "citation_id",                                                    :null => false
    t.integer  "stage_id",                                                       :null => false
    t.decimal  "length",      :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                       :default => "",    :null => false
    t.integer  "user_id",                                                        :null => false
    t.integer  "project_id",                                                     :null => false
    t.boolean  "mod",                                         :default => true
    t.boolean  "approved",                                    :default => false
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "stage_lifestyles", :force => true do |t|
    t.integer  "citation_id",                           :null => false
    t.integer  "stage_id",                              :null => false
    t.string   "lifestyle",   :default => "non-living", :null => false
    t.text     "comment"
    t.string   "datum",       :default => "",           :null => false
    t.integer  "user_id",                               :null => false
    t.integer  "project_id",                            :null => false
    t.boolean  "mod",         :default => true
    t.boolean  "approved",    :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "stage_masses", :force => true do |t|
    t.integer  "citation_id",                                                    :null => false
    t.integer  "stage_id",                                                       :null => false
    t.decimal  "mass",        :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                       :default => "",    :null => false
    t.integer  "user_id",                                                        :null => false
    t.integer  "project_id",                                                     :null => false
    t.boolean  "mod",                                         :default => true
    t.boolean  "approved",                                    :default => false
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "stage_max_depths", :force => true do |t|
    t.integer  "citation_id",                                                    :null => false
    t.integer  "stage_id",                                                       :null => false
    t.decimal  "max_depth",   :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                       :default => "",    :null => false
    t.integer  "user_id",                                                        :null => false
    t.integer  "project_id",                                                     :null => false
    t.boolean  "mod",                                         :default => true
    t.boolean  "approved",                                    :default => false
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "stage_mobilities", :force => true do |t|
    t.integer  "citation_id",                    :null => false
    t.integer  "stage_id",                       :null => false
    t.string   "mobility",    :default => "",    :null => false
    t.text     "comment"
    t.string   "datum",       :default => "",    :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "project_id",                     :null => false
    t.boolean  "mod",         :default => true
    t.boolean  "approved",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "stage_populations", :force => true do |t|
    t.integer  "citation_id",                                                    :null => false
    t.integer  "stage_id",                                                       :null => false
    t.decimal  "population",  :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                       :default => "",    :null => false
    t.integer  "user_id",                                                        :null => false
    t.integer  "project_id",                                                     :null => false
    t.boolean  "mod",                                         :default => true
    t.boolean  "approved",                                    :default => false
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "stage_prod_biomass_ratios", :force => true do |t|
    t.integer  "citation_id",                                                           :null => false
    t.integer  "stage_id",                                                              :null => false
    t.decimal  "prod_biomass_ratio", :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                              :default => "",    :null => false
    t.integer  "user_id",                                                               :null => false
    t.integer  "project_id",                                                            :null => false
    t.boolean  "mod",                                                :default => true
    t.boolean  "approved",                                           :default => false
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
  end

  create_table "stage_prod_consum_ratios", :force => true do |t|
    t.integer  "citation_id",                                                          :null => false
    t.integer  "stage_id",                                                             :null => false
    t.decimal  "prod_consum_ratio", :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                             :default => "",    :null => false
    t.integer  "user_id",                                                              :null => false
    t.integer  "project_id",                                                           :null => false
    t.boolean  "mod",                                               :default => true
    t.boolean  "approved",                                          :default => false
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  create_table "stage_reproductive_strategies", :force => true do |t|
    t.integer  "citation_id",                              :null => false
    t.integer  "stage_id",                                 :null => false
    t.string   "reproductive_strategy", :default => "",    :null => false
    t.text     "comment"
    t.string   "datum",                 :default => "",    :null => false
    t.integer  "user_id",                                  :null => false
    t.integer  "project_id",                               :null => false
    t.boolean  "mod",                   :default => true
    t.boolean  "approved",              :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "stage_residencies", :force => true do |t|
    t.integer  "citation_id",                    :null => false
    t.integer  "stage_id"
    t.string   "residency",   :default => "",    :null => false
    t.text     "comment"
    t.string   "datum",       :default => "",    :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "project_id",                     :null => false
    t.boolean  "mod",         :default => true
    t.boolean  "approved",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "stage_residency_times", :force => true do |t|
    t.integer  "citation_id",                                                       :null => false
    t.integer  "stage_id",                                                          :null => false
    t.decimal  "residency_time", :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                          :default => "",    :null => false
    t.integer  "user_id",                                                           :null => false
    t.integer  "project_id",                                                        :null => false
    t.boolean  "mod",                                            :default => true
    t.boolean  "approved",                                       :default => false
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  create_table "stage_unassimilated_consum_ratios", :force => true do |t|
    t.integer  "citation_id",                                                                   :null => false
    t.integer  "stage_id",                                                                      :null => false
    t.decimal  "unassimilated_consum_ratio", :precision => 64, :scale => 12,                    :null => false
    t.text     "comment"
    t.string   "datum",                                                      :default => "",    :null => false
    t.integer  "user_id",                                                                       :null => false
    t.integer  "project_id",                                                                    :null => false
    t.boolean  "mod",                                                        :default => true
    t.boolean  "approved",                                                   :default => false
    t.datetime "created_at",                                                                    :null => false
    t.datetime "updated_at",                                                                    :null => false
  end

  create_table "stages", :force => true do |t|
    t.string   "name",       :default => "",    :null => false
    t.integer  "node_id",                       :null => false
    t.integer  "user_id",                       :null => false
    t.integer  "project_id",                    :null => false
    t.boolean  "mod",        :default => true
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "trophic_interaction_observations", :force => true do |t|
    t.integer  "citation_id",                                                               :null => false
    t.integer  "trophic_interaction_id",                                                    :null => false
    t.integer  "location_id",                                                               :null => false
    t.string   "lethality",                                              :default => "",    :null => false
    t.string   "structures_consumed"
    t.decimal  "percentage_consumed",    :precision => 64, :scale => 12
    t.decimal  "percentage_diet",        :precision => 64, :scale => 12
    t.string   "percentage_diet_by"
    t.string   "preference"
    t.string   "observation_type"
    t.text     "comment"
    t.string   "datum",                                                  :default => "",    :null => false
    t.integer  "user_id",                                                                   :null => false
    t.integer  "project_id",                                                                :null => false
    t.boolean  "mod",                                                    :default => true
    t.boolean  "approved",                                               :default => false
    t.datetime "created_at",                                                                :null => false
    t.datetime "updated_at",                                                                :null => false
  end

  create_table "trophic_interactions", :force => true do |t|
    t.integer  "stage_1_id",                    :null => false
    t.integer  "stage_2_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.integer  "project_id",                    :null => false
    t.boolean  "mod",        :default => true
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname",              :default => "",     :null => false
    t.string   "lastname",               :default => "",     :null => false
    t.string   "username",               :default => "",     :null => false
    t.string   "email",                  :default => "",     :null => false
    t.string   "encrypted_password",     :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean  "approved",               :default => false,  :null => false
    t.datetime "remember_created_at"
    t.string   "role",                   :default => "User", :null => false
    t.integer  "project_id",                                 :null => false
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end

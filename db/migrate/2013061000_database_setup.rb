class DatabaseSetup < ActiveRecord::Migration
  def change
    # Author's table
    create_table :authors do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :suffix
      t.string :full_name
      t.integer :user_id
      t.boolean :approved
      
      t.timestamps
    end
    
    #author_cites table
    create_table :author_cites do |t|
      t.integer :author_id
      t.integer :citation_id
      t.integer :user_id
      t.boolean :approved

      t.timestamps
    end
    
    # Citations table
    create_table :citations do |t|
      t.string :title
      t.string :document
      t.integer :year
      t.text :abstract
      t.string :format
      t.string :format_title
      t.string :publisher
      t.integer :number
      t.integer :volume
      t.string :pages
      t.boolean :closed
      t.integer :user_id
      t.boolean :approved
      
      t.timestamps
    end
    
    # Competition Interactions Table
    create_table :competition_interactions do |t|
      t.integer :stage_1_id
      t.integer :stage_2_id
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved
      
      t.timestamps
    end
    
    # Competition Interaction Observation Table
		create_table :competition_interaction_observations do |t|
    	t.integer  :citation_id
    	t.integer  :competition_interaction_id
    	t.integer  :location_id
    	t.string   :observation_type
    	t.string   :competition_type
    	t.text     :comment
    	t.string   :datum
    	t.integer  :user_id
    	t.integer  :project_id
    	t.boolean  :approved
    
    	t.timestamps
  	end
    
    # Facilitation Interactions Table
    create_table :facilitation_interactions do |t|
      t.integer :stage_1_id
      t.integer :stage_2_id
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved
      
      t.timestamps
    end
    
    # Facilitation Interaction Observation
    create_table :facilitation_interaction_observations do |t|
      t.integer  :citation_id
    	t.integer  :facilitation_interaction_id
    	t.integer  :location_id
    	t.string   :observation_type
    	t.string   :facilitation_type
    	t.text     :comment
    	t.string   :datum
    	t.integer  :user_id
    	t.integer :project_id
    	t.boolean :approved

      t.timestamps
    end
    
    #Functional Groups table
    create_table :functional_groups do |t|
      t.string :name
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
    
    #Locations Table
  	create_table :locations do |t|
  		t.string :name
  		t.integer :left
  		t.integer :right
  		t.integer :parent
  		t.boolean :active
  		t.boolean :visible
  		t.integer :zoom_min
  		t.integer :zoom_max
  		t.integer :z_index
  		t.integer :user_id
  		t.integer :project_id
  		t.boolean :mod
  		t.boolean :approved
  	
  		t.timestamps
  	end
    
    #Locations Data table
    create_table :location_data do |t|
      t.text :latitude
      t.text :longitude
      t.integer :location_id
      t.string :name
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved
    end
    
    #Nodes table
    create_table :nodes do |t|
      t.integer :itis_id
      t.integer :non_itis_id
      t.string :working_name
      t.integer :functional_group_id
      t.string :native_status
      t.boolean :is_assemblage
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Node Max Ages table
    create_table :node_max_ages do |t|
      t.integer :citation_id
      t.integer :node_id
      t.float :max_age
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Node Ranges table
    create_table :node_ranges do |t|
      t.integer :citation_id
      t.integer :node_id
      t.integer :location_n_id
      t.integer :location_s_id
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Non-Itis Node Table
    create_table :non_itis do |t|
      t.integer :parent_id
      t.string :latin_name
      t.string :taxonomy_level
      t.boolean :parent_id_is_itis
      t.text :info
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Parasitic Interactions Table
    create_table :parasitic_interactions do |t|
      t.integer :stage_1_id
      t.integer :stage_2_id
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Parasitic Interaction Observation Table
    create_table :parasitic_interaction_observations do |t|
    	t.integer  :citation_id
    	t.integer  :parasitic_interaction_id
    	t.integer  :location_id
    	t.string   :endo_ecto
    	t.string   :lethality
    	t.decimal  :prevalence
    	t.decimal  :intensity
    	t.string   :parasite_type
    	t.string   :observation_type
    	t.text     :comment
    	t.string   :datum
    	t.integer  :user_id
    	t.integer :project_id
    	t.boolean :approved
    	
    	t.timestamps
    end
    
    # Projects Table
    create_table :projects do |t|
      t.string :name
      t.string :creator
      t.integer :user_id
      t.boolean :public
      t.boolean :approved

      t.timestamps
    end
    
    #Stages Table
    create_table :stages do |t|
    	t.string :name
      t.integer :node_id
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #stage Biomass Changes Table
    create_table :stage_biomass_changes do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :biomass_change
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Biomass Density Table
    create_table :stage_biomass_densities do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :biomass_density
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Consum Biomass Ratio Table
    create_table :stage_consum_biomass_ratios do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :consum_biomass_ratio
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Consumer Stradegy Table
    create_table :stage_consumer_strategies do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :consumer_strategy
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Drymass Table
    create_table :stage_drymasses do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :drymass
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Durations Table
    create_table :stage_durations do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :duration
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Fecundities Table
    create_table :stage_fecundities do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :fecundity
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Habitats Table
    create_table :stage_habitats do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :habitat
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Habitat Descriptors Table
    create_table :stage_habitat_descriptors do |t|
      t.string :descriptor
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Lengths table
    create_table :stage_lengths do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :length
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Length Fecundities Table
    create_table :stage_length_fecundities do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :length_fecundity
      t.decimal :a
      t.decimal :b
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    #Stage Length Weights Table
    create_table :stage_length_weights do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :length_weight
      t.decimal :a
      t.decimal :b
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage LIfestyles table
    create_table :stage_lifestyles do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :lifestyle
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Masses Table
    create_table :stage_masses do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :mass
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Max Depths Table
    create_table :stage_max_depths do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :max_depth
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Mobilities Table
    create_table :stage_mobilities do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :mobility
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Populations Table
    create_table :stage_populations do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :population
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Prod Biomass Ratios Table
    create_table :stage_prod_biomass_ratios do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :prod_biomass_ratio
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Prod Consum Ratios Table
    create_table :stage_prod_consum_ratios do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :prod_consum_ratio
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Reproductive Strategies Table
    create_table :stage_reproductive_strategies do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :reproductive_strategy
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Residencies Table
    create_table :stage_residencies do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :residency
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Residency Times Table
    create_table :stage_residency_times do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :residency_time
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Stage Unassimilated Consum Ratios Table
    create_table :stage_unassimilated_consum_ratios do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :unassimilated_consum_ratio
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Trophic Interactions Table
    create_table :trophic_interactions do |t|
      t.integer :stage_1_id
      t.integer :stage_2_id
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    # Trophic Interaction Observations Table
    create_table :trophic_interaction_observations do |t|
      t.integer :citation_id
      t.integer :trophic_interaction_id
      t.integer :location_id
      t.string :lethality
      t.string :structures_consumed
      t.decimal :percentage_consumed
      t.decimal :percentage_diet
      t.string :percentage_diet_by
      t.string :preference
      t.string :observation_type
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
    
    
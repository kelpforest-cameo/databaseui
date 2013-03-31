FoodWebBuilder::Application.routes.draw do
		#Load resources for models
	
	resources :authors
	resources :author_cites
	resources :citation
	resources :competition_interation
	resources :compeition_interaction_observation
	resources :faciliation_interaction
	resources :facilitation_interaction_observation
	resources :functional_group
	resources :location
	resources :location_data
	resources :node
	resources :node_max_age
	resources :node_range
	resources :non_itis
	resources :parasitic_interaction
	resources :parasitic_interaction_observation
	resources :stage
	resources :stage_biomass_change
	resources :stage_biomass_density
	resources :stage_consume_biomass_ratio
	resources :stage_consumer_strategy
	resources :stage_drymass
	resources :stage_duration
	resources :stage_fecundity
	resources :stage_habitat
	resources :stage_habitat_descriptor
	resources :stage_length
	resources :stage_length_fecundity
	resources :stage_length_weight
	resources :stage_lifestyle
	resources :stage_masses
	resources :stage_max_depth
	resources :stage_mobility
	resources :stage_populations
	resources :stage_prod_biomass_ratio
	resources :stage_prod_consum_ratio
	resources :stage_reproductive_strategy
	resources :stage_residency
	resources :stage_residency_time
	resources :stage_unassimilated_consum_ratio
	resources :trophic_interaction
	resources :trophic_interaction_observation

	# Mount the Rails Admin engine
	mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
	# Configure routes for authenticated User to dashboard
  authenticated :user do
  	root :to => 'dashboard#index' 
  end
  # Default root to home/index.html.erb
  root :to =>"home#index"
  devise_for :users
  resources :users
  
  # add some matching to make coding easier
  match 'about' => 'home#about'
  match 'help' => 'home#help'
  match 'visualization' => 'visualization#index'
  match 'dataentry' => 'dashboard#dataentry'
	

end

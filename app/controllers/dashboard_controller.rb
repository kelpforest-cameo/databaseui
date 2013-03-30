class DashboardController < ApplicationController
  load_and_authorize_resource :only => [:show, :edit]
  def index
  end
  def dataentry
  @author = Author.new
  @citation = Citation.new
  @citationlist = Citation.all
  end

def show
  #Authors table
  @author = Author.find(params[:id])
  authorize! :read, @author
  
  #Author_cites table
  @author_cites = Author_cites.find(params[:id])
  authorize! :read, @author_cites

  #Citation table
  @citation = Citation.find(params[:id])
  authorize! :read, @citation
  
  #Competition_interaction table
  @competition_interaction = Competition_interaction.find(params[:id])
  authorize! :read, @Competition_interaction
  
  #Competition_interaction_observation table
  @competition_iteraction_observation = Competition_interaction_observation.find(params[:id])
  authorize! :read, @competition_iteraction_observation

  #Facilitation_interaction table
  @facilitation_interaction = Facilitation_interaction.find(params[:id])
  authorize! :read, @facilitation_interaction
  
  #Facilitation_interaction_observation table
  @facilitation_interaction_observation = facilitation_interaction_observation.find(params[:id])
  authorize! :read, @facilitation_interaction_observation
  
  #Functional_group table
  @functional_group = Functional_group.find(params[:id])
  authorize! :read, @functional_group
  
  #location table
  @location = Location.find(params[:id])
  authorize! :read, @location
  
  #location_data table
  @location_data = Location_data.find(params[:id])
  authorize! :read, @author
  
  #node table
  @node = Node.find(params[:id])
  authorize! :read, @node
  
  #node_max_age table
  @node_max_age = Node_max_age.find(params[:id])
  authorize! :read, @node_max_age
  
  #Node_range table
  @node_range = Node_range.find(params[:id])
  authorize! :read, @node_range
  
  #Non_Itis table
  @non_itis = Non_Itis.find(params[:id])
  authorize! :read, @non_itis
  
  #Parasitic_interaction table
  @parasitic_interaction = Parasitic_interaction.find(params[:id])
  authorize! :read, @parasitic_interaction
  
  #Parasitic_interaction_observation table
  @parasitic_interaction_observation = Parasitic_interaction_observation.find(params[:id])
  authorize! :read, @parasitic_interaction_observation
  
  #stage table
  @stage = Stage.find(params[:id])
  authorize! :read, @stage
  
  #Stage_biomass_change table
  @stage_biomass_change = Stage_biomass_change.find(params[:id])
  authorize! :read, @stage_biomass_change
  
  #Stage_biomass_density table
  @stage_biomass_density = Stage_biomass_density.find(params[:id])
  authorize! :read, @stage_biomass_density
  
  #Stage_consume_biomass_ratio table
  @stage_consume_biomass_ratio = Stage_consume_biomass_ratio.find(params[:id])
  authorize! :read, @stage_consume_biomass_ratio
  
  # Stage_consumer_strategy table
  @stage_consumer_strategy = Stage_consumer_strategy.find(params[:id])
  authorize! :read, @stage_consumer_strategy
  
  #Stage_drymass table
  @stage_drymass = Stage_drymass.find(params[:id])
  authorize! :read, @stage_drymass
  
  # Stage_duration table
  @stage_duration = Stage_duration.find(params[:id])
  authorize! :read, @stage_duration
  
  # Stage_fecundity table
  @stage_fecundity = Stage_fecundity.find(params[:id])
  authorize! :read, @stage_fecundity
  
  # Stage_habitat table
  @stage_habitat = Stage_habitat.find(params[:id])
  authorize! :read, @stage_habitat
  
  # Stage_habitat_descriptor table
  @stage_habitat_descriptor = Stage_habitat_descriptor.find(params[:id])
  authorize! :read, @stage_habitat_descriptor
  
  # Stage_length table
  @stage_length = Stage_length.find(params[:id])
  authorize! :read, @stage_length
  
  # Stage_length_fecundity table
  @stage_length_fecundity = Stage_length_fecundity.find(params[:id])
  authorize! :read, @stage_length_fecundity
  
  # Stage_length_weight table
  @stage_length_weight = Stage_length_weight.find(params[:id])
  authorize! :read, @stage_length_weight
  
  # Stage_lifestyle table
  @stage_lifestyle = Stage_lifestyle.find(params[:id])
  authorize! :read, @stage_lifestyle
  
  # Stage_masses table
  @stage_masses = Stage_masses.find(params[:id])
  authorize! :read, @stage_masses
  
  # Stage_max_depth table
  @stage_max_depth = Stage_max_depth.find(params[:id])
  authorize! :read, @stage_max_depth
  
  # Stage_mobility table
  @stage_mobility = Stage_mobility.find(params[:id])
  authorize! :read, @stage_mobility
  
  # Stage_populations table
  @stage_populations = Stage_populations.find(params[:id])
  authorize! :read, @stage_populations
  
  # Stage_prod_biomass_ratio table
  @stage_prod_biomass_ratio = Stage_prod_biomass_ratio.find(params[:id])
  authorize! :read, @stage_prod_biomass_ratio
  
  # Stage_prod_consum_ratio table
  @stage_prod_consum_ratio = Stage_prod_consum_ratio.find(params[:id])
  authorize! :read, @stage_prod_consum_ratio
  
  # Stage_reproductive_strategy table
  @stage_reproductive_strategy = Stage_reproductive_strategy.find(params[:id])
  authorize! :read, @stage_reproductive_strategy
  
  # Stage_residency table
  @stage_residency = Stage_residency.find(params[:id])
  authorize! :read, @stage_residency
  
  # Stage_residency_time table
  @stage_residency_time = Stage_residency_time.find(params[:id])
  authorize! :read, @stage_residency_time
  
  # Stage_unassimilated_consum_ratio table
  @stage_unassimilated_consum_ratio = Stage_unassimilated_consum_ratio.find(params[:id])
  authorize! :read, @stage_unassimilated_consum_ratio
  
  # Trophic_interaction table
  @trophic_interaction = Trophic_interaction.find(params[:id])
  authorize! :read, @trophic_interaction
  
  # Trophic_interaction_observation table
  @trophic_interaction_observation = Trophic_interaction_observation.find(params[:id])
  authorize! :read, @trophic_interaction_observation
  
  #User table
  @user = User.find(params[:id])
  authorize! :read, @user
end

def edit
  #Authors table
  @author = Author.find(params[:id])
  authorize! :update, :create, :destroy, @author
  
  #Author_cites table
  @author_cites = Author_cites.find(params[:id])
  authorize! :update, :create, :destroy, @author_cites

  #Citation table
  @citation = Citation.find(params[:id])
  authorize! :update, :create, :destroy, @citation
  
  #Competition_interaction table
  @competition_interaction = Competition_interaction.find(params[:id])
  authorize! :update, :create, :destroy, @Competition_interaction
  
  #Competition_interaction_observation table
  @competition_iteraction_observation = Competition_interaction_observation.find(params[:id])
  authorize! :update, :create, :destroy, @competition_iteraction_observation

  #Facilitation_interaction table
  @facilitation_interaction = Facilitation_interaction.find(params[:id])
  authorize! :update, :create, :destroy, @facilitation_interaction
  
  #Facilitation_interaction_observation table
  @facilitation_interaction_observation = facilitation_interaction_observation.find(params[:id])
  authorize! :update, :create, :destroy, @facilitation_interaction_observation
  
  #Functional_group table
  @functional_group = Functional_group.find(params[:id])
  authorize! :update, :create, :destroy, @functional_group
  
  #location table
  @location = Location.find(params[:id])
  authorize! :update, :create, :destroy, @location
  
  #location_data table
  @location_data = Location_data.find(params[:id])
  authorize! :update, :create, :destroy, @author
  
  #node table
  @node = Node.find(params[:id])
  authorize! :update, :create, :destroy, @node
  
  #node_max_age table
  @node_max_age = Node_max_age.find(params[:id])
  authorize! :update, :create, :destroy, @node_max_age
  
  #Node_range table
  @node_range = Node_range.find(params[:id])
  authorize! :update, :create, :destroy, @node_range
  
  #Non_Itis table
  @non_itis = Non_Itis.find(params[:id])
  authorize! :update, :create, :destroy, @non_itis
  
  #Parasitic_interaction table
  @parasitic_interaction = Parasitic_interaction.find(params[:id])
  authorize! :update, :create, :destroy, @parasitic_interaction
  
  #Parasitic_interaction_observation table
  @parasitic_interaction_observation = Parasitic_interaction_observation.find(params[:id])
  authorize! :update, :create, :destroy, @parasitic_interaction_observation
  
  #stage table
  @stage = Stage.find(params[:id])
  authorize! :update, :create, :destroy, @stage
  
  #Stage_biomass_change table
  @stage_biomass_change = Stage_biomass_change.find(params[:id])
  authorize! :update, :create, :destroy, @stage_biomass_change
  
  #Stage_biomass_density table
  @stage_biomass_density = Stage_biomass_density.find(params[:id])
  authorize! :update, :create, :destroy, @stage_biomass_density
  
  #Stage_consume_biomass_ratio table
  @stage_consume_biomass_ratio = Stage_consume_biomass_ratio.find(params[:id])
  authorize! :update, :create, :destroy, @stage_consume_biomass_ratio
  
  # Stage_consumer_strategy table
  @stage_consumer_strategy = Stage_consumer_strategy.find(params[:id])
  authorize! :update, :create, :destroy, @stage_consumer_strategy
  
  #Stage_drymass table
  @stage_drymass = Stage_drymass.find(params[:id])
  authorize! :update, :create, :destroy, @stage_drymass
  
  # Stage_duration table
  @stage_duration = Stage_duration.find(params[:id])
  authorize! :update, :create, :destroy, @stage_duration
  
  # Stage_fecundity table
  @stage_fecundity = Stage_fecundity.find(params[:id])
  authorize! :update, :create, :destroy, @stage_fecundity
  
  # Stage_habitat table
  @stage_habitat = Stage_habitat.find(params[:id])
  authorize! :update, :create, :destroy, @stage_habitat
  
  # Stage_habitat_descriptor table
  @stage_habitat_descriptor = Stage_habitat_descriptor.find(params[:id])
  authorize! :update, :create, :destroy, @stage_habitat_descriptor
  
  # Stage_length table
  @stage_length = Stage_length.find(params[:id])
  authorize! :update, :create, :destroy, @stage_length
  
  # Stage_length_fecundity table
  @stage_length_fecundity = Stage_length_fecundity.find(params[:id])
  authorize! :update, :create, :destroy, @stage_length_fecundity
  
  # Stage_length_weight table
  @stage_length_weight = Stage_length_weight.find(params[:id])
  authorize! :update, :create, :destroy, @stage_length_weight
  
  # Stage_lifestyle table
  @stage_lifestyle = Stage_lifestyle.find(params[:id])
  authorize! :update, :create, :destroy, @stage_lifestyle
  
  # Stage_masses table
  @stage_masses = Stage_masses.find(params[:id])
  authorize! :update, :create, :destroy, @stage_masses
  
  # Stage_max_depth table
  @stage_max_depth = Stage_max_depth.find(params[:id])
  authorize! :update, :create, :destroy, @stage_max_depth
  
  # Stage_mobility table
  @stage_mobility = Stage_mobility.find(params[:id])
  authorize! :update, :create, :destroy, @stage_mobility
  
  # Stage_populations table
  @stage_populations = Stage_populations.find(params[:id])
  authorize! :update, :create, :destroy, @stage_populations
  
  # Stage_prod_biomass_ratio table
  @stage_prod_biomass_ratio = Stage_prod_biomass_ratio.find(params[:id])
  authorize! :update, :create, :destroy, @stage_prod_biomass_ratio
  
  # Stage_prod_consum_ratio table
  @stage_prod_consum_ratio = Stage_prod_consum_ratio.find(params[:id])
  authorize! :update, :create, :destroy, @stage_prod_consum_ratio
  
  # Stage_reproductive_strategy table
  @stage_reproductive_strategy = Stage_reproductive_strategy.find(params[:id])
  authorize! :update, :create, :destroy, @stage_reproductive_strategy
  
  # Stage_residency table
  @stage_residency = Stage_residency.find(params[:id])
  authorize! :update, :create, :destroy, @stage_residency
  
  # Stage_residency_time table
  @stage_residency_time = Stage_residency_time.find(params[:id])
  authorize! :update, :create, :destroy, @stage_residency_time
  
  # Stage_unassimilated_consum_ratio table
  @stage_unassimilated_consum_ratio = Stage_unassimilated_consum_ratio.find(params[:id])
  authorize! :update, :create, :destroy, @stage_unassimilated_consum_ratio
  
  # Trophic_interaction table
  @trophic_interaction = Trophic_interaction.find(params[:id])
  authorize! :update, :create, :destroy, @trophic_interaction
  
  # Trophic_interaction_observation table
  @trophic_interaction_observation = Trophic_interaction_observation.find(params[:id])
  authorize! :update, :create, :destroy, @trophic_interaction_observation
  
  #User table
  @user = User.find(params[:id])
  authorize! :update, :create, :destroy, @user
end
    rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end

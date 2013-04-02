class Ability
	include CanCan::Ability

	def initialize(user)
		# Define abilities for the passed in user here. For example:

		user ||= User.new # guest user (not logged in)
		if user.role? :user
			can :read, :all
			can :show, :all
			
			# Should be able to read everything but users
			cannot :read, User
			cannot :show, User
			
			# Author model
			can :create, Author
			can [:update, :edit, :destroy], Author, :user_id => user.id
			
			# Author_cite
			can :create, Author_Cite
			can [:update, :edit, :destroy], Author_Cite, :user_id => user.id
			
			# Citation
			can :create, Citation
			can [:update, :edit, :destroy], Citation, :user_id=>user.id
			
			# Competition_interaction
			can :create, Competition_Interaction
			can [:update, :edit, :destroy], Competition_Interaction, :user_id=>user.id
			
			# Competition_interaction_observation
			can :create, Competition_Interaction_Observation
			can [:update, :edit, :destroy], Competition_Interaction_Observation, :user_id => user.id
			
			# Facilitation_Interaction
			can :create, Facilitation_Interaction
			can [:update, :edit, :destroy], Facilitation_Interaction, :user_id => user.id
			
			# Facilitation_Interaction_Observation
			can :create, Facilitation_Interaction_Observation
			can [:update, :edit, :destroy], Facilitation_Interaction_Observation, :user_id => user.id
			
			# User can only read functional_groups 
			
			#User can only read the locations, locations_data tables
			
			# Node
			can :create, Node
			can [:update, :edit, :destroy], Node, :user_id => user.id
			
			# Node_Max_Age
			can :create, Node_Max_Age
			can [:update, :edit, :destroy], Node_Max_Age, :user_id => user.id
			
			# Node_Range
			can :create, Node_Range
			can [:update, :edit, :destroy], Node_Range, :user_id => user.id
			
			# Non_Itis
			can :create, Non_Iti
			can [:update, :edit, :destroy], Non_Iti, :user_id => user.id
			
			# Parasitic_Interaction
			can :create, Parasitic_Interaction
			can [:edit, :update, :destroy], Parasitic_Interaction, :user_id => user.id
			
			# Parasitic_Interaction_Observation
			can :create, Parasitic_Interaction_Observation
			can [:edit, :update, :destroy], Parasitic_Interaction_Observation, :user_id => user.id
			
			# Stage
			can :create, Stage
			can [:edit, :update, :destroy], Stage, :user_id => user.id
			
			# Stage_Biomass_Change
			can :create, Stage_Biomass_Change
			can [:edit, :update, :destroy], Stage_Biomass_Change, :user_id => user.id
			
			# Stage_Biomass_Density
			can :create, Stage_Biomass_Density
			can [:edit, :update, :destroy], Stage_Biomass_Density, :user_id => user.id
			
			# Stage_Consume_Biomass_Ratio
			can :create, Stage_Consume_Biomass_Ratio
			can [:edit, :update, :destroy], Stage_Consume_Biomass_Ratio, :user_id => user.id
			
			# Stage_Consumer_Strategy
			can :create, Stage_Consumer_Strategy
			can [:edit, :update, :destroy], Stage_Consumer_Strategy, :user_id => user.id
			
			# Stage_Drymass
			can :create, Stage_Drymass
			can [:edit, :update, :destroy], Stage_Drymass, :user_id => user.id
			
			# Stage_Duration
			can :create, Stage_Duration
			can [:edit, :update, :destroy], Stage_Duration, :user_id => user.id
			
			# Stage_Fecundity
			can :create, Stage_Fecundity
			can [:edit, :update, :destroy], Stage_Fecundity, :user_id => user.id
			
			# Stage_Habitat
			can :create, Stage_Habitat
			can [:edit, :update, :destroy], Stage_Habitat, :user_id => user.id
			
			# Can only read Stage_Habitat_Descriptor
			
			# Stage_Length
			can :create, Stage_Length
			can [:edit, :update, :destroy], Stage_Length, :user_id => user.id
			
			# Stage_Length_Fecundity
			can :create, Stage_Length_Fecundity
			can [:edit, :update, :destroy], Stage_Length_Fecundity, :user_id => user.id
			
			# Stage_Length_Weight
			can :create, Stage_Length_Weight
			can [:edit, :update, :destroy], Stage_Length_Weight, :user_id => user.id
			
			# Stage_Lifestyle
			can :create, Stage_Lifestyle
			can [:edit, :update, :destroy], Stage_Lifestyle, :user_id => user.id
			
			# Stage_Masses
			can :create, Stage_Masses
			can [:edit, :update, :destroy], Stage_Masses, :user_id => user.id
			
			# Stage_Max_Depth
			can :create, Stage_Max_Depth
			can [:edit, :update, :destroy], Stage_Max_Depth, :user_id => user.id
			
			# Stage_Mobility
			can :create, Stage_Mobility
			can [:edit, :update, :destroy], Stage_Mobility, :user_id => user.id
			
			# Stage_Populations
			can :create, Stage_Populations
			can [:edit, :update, :destroy], Stage_Populations, :user_id => user.id
			
			# Stage_Prod_Biomass_Ratio
			can :create, Stage_Prod_Biomass_Ratio
			can [:edit, :update, :destroy], Stage_Prod_Biomass_Ratio, :user_id => user.id
			
			# Stage_Prod_Consum_Ratio
			can :create, Stage_Prod_Consum_Ratio
			can [:edit, :update, :destroy], Stage_Prod_Consum_Ratio, :user_id => user.id
			
			# Stage_Reproductive_Strategy
			can :create, Stage_Reproductive_Strategy
			can [:edit, :update, :destroy], Stage_Reproductive_Strategy, :user_id => user.id
			
			# Stage_Residency
			can :create, Stage_Residency
			can [:edit, :update, :destroy], Stage_Residency, :user_id => user.id
			
			# Stage_Residency_Time
			can :create, Stage_Residency_Time
			can [:edit, :update, :destroy], Stage_Residency_Time, :user_id => user.id
			
			# Stage_Unassimilated_Consum_Ratio
			can :create, Stage_Unassimilated_Consum_Ratio
			can [:edit, :update, :destroy], Stage_Unassimilated_Consum_Ratio, :user_id => user.id
			
			# Trophic_Interaction
			can :create, Trophic_Interaction
			can [:edit, :update, :destroy], Trophic_Interaction, :user_id => user.id
			
			# Trophic_Interaction_Observation
			can :create, Trophic_Interaction_Observation
			can [:edit, :update, :destroy], Trophic_Interaction_Observation, :user_id => user.id
			
		end
		
		if user.role? :moderator
			can :read, :all
			
			# Locations
			can :create, Locations
			can :manage, Locations, :user_id => user.id
			
			# Location_Data
			can :create, Location_Data
			can :manage, Location_Data, :user_id => user.id
			
			# Stage_Habitat_Descriptor
			can :create, Stage_Habitat_Descriptor
			can :manage, Stage_Habitat_Descriptor, :user_id => user.id
			
			
		end
		
		if user.role? :admin
			can :manage, :all
		end
		
		else
			can :read, :all
			can :show, :all
			cannot [:read, :show] , User
	end
end

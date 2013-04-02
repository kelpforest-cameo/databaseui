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
			
			# For Author model
			can :create, Author
			can [:update, :edit, :destroy], Author, :user_id => user.id
			
			# For Author_cite
			can :create, Author_Cite
			can [:update, :edit, :destroy], Author_Cite, :user_id => user.id
			
			# For Citation
			can :create, Citation
			can [:update, :edit, :destroy], Citation, :user_id=>user.id
			
			# For Competition_interaction
			can :create, Competition_Interaction
			can [:update, :edit, :destroy], Competition_Interaction, :user_id=>user.id
			
			# For Competition_interaction_observation
			can :create, Competition_Interaction_Observation
			can [:update, :edit, :destroy], Competition_Interaction_Observation, :user_id => user.id
			
			# For models that start with F user cannot add functional_groups
			can :create, [Facilitation_Interaction, Facilitation_Interaction_Observation]
			can [:update, :edit, :destroy], [Facilitation_Interaction, Facilitation_Interaction_Observation], :user_id => user.id
			
			#User can only read the locations, locations_data tables
			
			# For nodes
			can :create, [Node, Node_Max_Age, Node_Range]
			can [:update, :edit, :destroy], [Node, Node_Max_Age, Node_Range], :user_id => user.id
		end
		
		if user.role? :moderator
			can :read, :all
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

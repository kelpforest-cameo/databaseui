class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

       user ||= User.new # guest user (not logged in)
       if user.role? :user
       	can :read, :all
       	can [:show,:update, :destroy, :edit], User, :id => user.id
       	can [:show, :destroy, :edit, :create], Author, :user_id => user.id
       end
       if user.role? :moderator
         can :read, :all
       end
       if user.role? :admin
         can :manage, :all
       end
	  else
	  	can :read, :all
  end
end

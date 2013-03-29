class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

       user ||= User.new # guest user (not logged in)
       if user.role? :user
       	can :read, :all
       	can :manage, User, :id =>{:id => user.id}
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

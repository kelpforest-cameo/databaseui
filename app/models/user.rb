class User < ActiveRecord::Base
  rolify
  # admin = super user, moderator = scientist user = data entry
  ROLES = %w[user moderator admin]
  def role?(base_role)
    ROLES.index(base_role.to_s) <=ROLES.index(role)
  end
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Setup accessible (or protected) attributes for your model
  
  # This is for login with username or e-mail
  attr_accessor :login
  
   attr_accessible :email, :password, :password_confirmation, :remember_me , :role , :approved , :username, :firstname, :lastname
  # attr_accessible :title, :body
  
  # This is for admin approval of user accounts
  def active_for_authentication? 
  	super && approved?
  	
	end 
	
	def inactive_message 
  	if !approved?
  	  :inactive
  	else 
    	super
  	end 
	end
	
	# For listing users
	def index
 	 if params[:approved] == "false"
  	  @users = User.find_all_by_approved(false)
  	else
  	  @users = User.all
  	end
	end
	
	# Need to override the find for authentication method
	def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
end

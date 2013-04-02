class User < ActiveRecord::Base
  rolify
  resourcify
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
  attr_accessible :email, :password, :password_confirmation, :remember_me , :role
  # attr_accessible :title, :body
end

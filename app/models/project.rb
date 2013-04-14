class Project < ActiveRecord::Base
  attr_accessible :approved, :name, :owner, :public, :user_id
  has_many :users
end

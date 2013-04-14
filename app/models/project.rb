class Project < ActiveRecord::Base
  attr_accessible :approved, :name, :creator, :public, :user_id
  validates :name, :presence => true,
  								 :uniqueness => true
  								 
  has_many :users
end

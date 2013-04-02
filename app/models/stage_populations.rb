class Stage_Populations < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :population, :stage_id, :user_id
  has_many :citations
  belongs_to :stage 
  belongs_to :user
end

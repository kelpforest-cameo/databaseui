class Stage_Biomass_Density < ActiveRecord::Base
  attr_accessible :biomass_density, :citation_id, :comment, :datum, :stage_id, :user_id
  has_many :citations
  belongs_to :user
  belongs_to :stage
end

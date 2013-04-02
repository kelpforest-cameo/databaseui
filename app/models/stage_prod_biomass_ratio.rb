class Stage_Prod_Biomass_Ratio < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :prod_biomass_ratio, :stage_id, :user_id
  has_many :citations
  belongs_to :stage
  belongs_to :user
end

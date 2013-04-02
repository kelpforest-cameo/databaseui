class Stage_Biomass_Change < ActiveRecord::Base
  attr_accessible :biomass_change, :citation_id, :comment, :datum, :stage_id, :user_id
  has_many :citations
  belongs_to :stage
  belongs_to :user
end

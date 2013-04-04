class StageBiomassDensity < ActiveRecord::Base
  attr_accessible :biomass_density, :citation_id, :comment, :datum, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end


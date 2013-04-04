class Stage_Consume_Biomass_Ratio < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :consume_biomass_ratio, :datum, :stage_id, :user_id
belongs_to :user
end

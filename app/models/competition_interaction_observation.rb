class Competition_Interaction_Observation < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :competition_interaction_id, :competition_type, :datum, :location_id, :observation_type, :user_id
belongs_to :user
end

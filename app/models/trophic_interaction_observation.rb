class TrophicInteractionObservation < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :lethality, :location_id, :observation_type, :percentage_consumed, :percentage_diet, :percentage_diet_by, :preference, :structures_consumed, :trophic_interaction_id, :user_id, :project_id, :mod, :approved
  belongs_to :citation
  belongs_to :trophic_interaction
  belongs_to :user
  belongs_to :project
  has_one :location

end

class FacilitationInteractionObservation < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :facilitation_interaction_id, :facilitation_type, :location_id, :observation_type, :user_id, :project_id, :mod, :approved
  belongs_to :user
  belongs_to :project
  belongs_to :citation
  belongs_to :facilitation_interaction
  has_one :location
end

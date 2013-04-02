class FacilitationInteractionObservation < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :facilitation_interaction_id, :facilitation_type, :location_id, :observation_type, :user_id
belongs_to :user
end

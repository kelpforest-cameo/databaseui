class CompetitionInteractionObservation < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :competition_interaction_id, :competition_type, :datum, :location_id, :observation_type, :user_id, :project_id, :mod, :approved
  belongs_to :user
  belongs_to :citation
  belongs_to :project
  belongs_to :comptetition_interaction
  has_one :location
end

class ParasiticInteractionObservation < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :endo_ecto, :intensity, :lethality, :location_id, :observation_type, :parasite_type, :parasitic_interaction_id, :prevalence, :user_id, :project_id, :mod, :approved
  belongs_to :citation
  belongs_to :project
  belongs_to :parasitic_interaction
  belongs_to :user
  has_one :location
end

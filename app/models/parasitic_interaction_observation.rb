class ParasiticInteractionObservation < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :endo_ecto, :intensity, :lethality, :location_id, :observation_type, :parasite_type, :parasitic_interaction_id, :prevalence, :user_id
end

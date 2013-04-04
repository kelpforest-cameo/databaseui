class Parasitic_Interaction_Observation < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :endo_ecto, :intensity, :lethality, :location_id, :observation_type, :parasite_type, :parasitic_interaction_id, :prevalence, :user_id
belongs_to :user
belongs_to :citation
belongs_to :locations
belongs_to :parasitic_interaction
end

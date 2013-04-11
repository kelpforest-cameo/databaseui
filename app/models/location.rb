class Location < ActiveRecord::Base
  attr_accessible :active, :left, :name, :parent, :right, :visible, :z_index, :zoom_max, :zoom_min, :user_id, :project_id, :mod, :approved
belongs_to :user
belongs_to :competition_interaction_observation
belongs_to :facilitation_interaction_observation
belongs_to :parasitic_interaction_obseravation
belongs_to :trophic_interaction_observation
belongs_to :project

end

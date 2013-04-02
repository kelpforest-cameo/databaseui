<<<<<<< HEAD:app/models/facilitation_interactions.rb
class FacilitationInteractions < ActiveRecord::Base
  attr_accessible :stage_1_id, :stage_2_id, :user_id
  belongs_to :user
  has_many :facilitation_interaction_observations, :dependent => :destroy
end
=======
class Competition_Interaction < ActiveRecord::Base
  attr_accessible :stage_1_id, :stage_2_id, :user_id
  belongs_to :user
end
>>>>>>> upstream/umass_branch:app/models/competition_interaction.rb

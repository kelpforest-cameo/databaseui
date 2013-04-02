<<<<<<< HEAD:app/models/competition_interactions.rb
class CompetitionInteractions < ActiveRecord::Base
  attr_accessible :stage_1_id, :stage_2_id, :user_id
  belongs_to :user
  has_many :competition_interaction_observations, :dependent => :destroy
end
=======
class Facilitation_Interaction < ActiveRecord::Base
  attr_accessible :stage_1_id, :stage_2_id, :user_id
  belongs_to :user
end
>>>>>>> upstream/umass_branch:app/models/facilitation_interaction.rb

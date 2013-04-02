<<<<<<< HEAD:app/models/trophic_interactions.rb
class TrophicInteractions < ActiveRecord::Base
  attr_accessible :stage_1_id, :stage_2_id, :user_id
  belongs_to :user
  has_many :trophic_interaction_observations, :dependent => :destroy
end
=======
class TrophicInteraction < ActiveRecord::Base
  attr_accessible :stage_1_id, :stage_2_id, :user_id
  belongs_to :user
end
>>>>>>> upstream/umass_branch:app/models/trophic_interaction.rb

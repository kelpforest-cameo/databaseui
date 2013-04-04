<<<<<<< HEAD
<<<<<<< HEAD:app/models/trophic_interactions.rb
class TrophicInteractions < ActiveRecord::Base
  attr_accessible :stage_1_id, :stage_2_id, :user_id
  belongs_to :user
  has_many :trophic_interaction_observations, :dependent => :destroy
end
=======
class TrophicInteraction < ActiveRecord::Base
=======
class Trophic_Interaction < ActiveRecord::Base
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
  attr_accessible :stage_1_id, :stage_2_id, :user_id
  belongs_to :user
end
>>>>>>> upstream/umass_branch:app/models/trophic_interaction.rb

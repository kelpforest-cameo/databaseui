<<<<<<< HEAD
<<<<<<< HEAD:app/models/stage_biomass_changes.rb
class StageBiomassChanges < ActiveRecord::Base
  attr_accessible :biomass_change, :citation_id, :comment, :datum, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end
=======
class StageBiomassChange < ActiveRecord::Base
=======
class Stage_Biomass_Change < ActiveRecord::Base
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
  attr_accessible :biomass_change, :citation_id, :comment, :datum, :stage_id, :user_id
  has_many :citations
  belongs_to :stage
  belongs_to :user
end
>>>>>>> upstream/umass_branch:app/models/stage_biomass_change.rb

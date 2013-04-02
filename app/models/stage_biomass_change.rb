<<<<<<< HEAD:app/models/stage_biomass_changes.rb
class StageBiomassChanges < ActiveRecord::Base
  attr_accessible :biomass_change, :citation_id, :comment, :datum, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end
=======
class StageBiomassChange < ActiveRecord::Base
  attr_accessible :biomass_change, :citation_id, :comment, :datum, :stage_id, :user_id
  has_many :citations
  belongs_to :stage, :user
end
>>>>>>> upstream/umass_branch:app/models/stage_biomass_change.rb

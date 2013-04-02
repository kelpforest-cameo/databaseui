class StageMobility < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
=======
  attr_accessible :cite_id, :comment, :datum, :mobility, :stage_id, :user_id
>>>>>>> upstream/umass_branch
end

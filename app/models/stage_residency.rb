<<<<<<< HEAD
class StageResidency < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
=======
  attr_accessible :cite_id, :comment, :datum, :residency, :stage_id, :user_id
>>>>>>> upstream/umass_branch
=======
class Stage_Residency < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :residency, :stage_id, :user_id

belongs_to :user
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
end

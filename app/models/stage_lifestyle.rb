<<<<<<< HEAD
class StageLifestyle < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
=======
class Stage_Lifestyle < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :lifestyle, :stage_id, :user_id
<<<<<<< HEAD
>>>>>>> upstream/umass_branch
=======

belongs_to :user
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
end

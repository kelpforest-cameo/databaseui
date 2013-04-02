<<<<<<< HEAD
class StageLifestyle < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
=======
class Stage_Lifestyle < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :lifestyle, :stage_id, :user_id
>>>>>>> upstream/umass_branch
end

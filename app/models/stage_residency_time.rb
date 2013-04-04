<<<<<<< HEAD
<<<<<<< HEAD:app/models/stage_residency_times.rb
class StageResidencyTimes < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :residency_time, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end
=======
class StageResidencyTime < ActiveRecord::Base
=======
class Stage_Residency_Time < ActiveRecord::Base
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
  attr_accessible :citation_id, :comment, :datum, :residency_time, :stage_id, :user_id
  has_many :citations
  belongs_to :stage
  belongs_to :user
end
>>>>>>> upstream/umass_branch:app/models/stage_residency_time.rb

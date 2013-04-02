<<<<<<< HEAD:app/models/stage_residency_times.rb
class StageResidencyTimes < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :residency_time, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end
=======
class StageResidencyTime < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :residency_time, :stage_id, :user_id
  has_many :citations
  belongs_to :stage, :user
end
>>>>>>> upstream/umass_branch:app/models/stage_residency_time.rb

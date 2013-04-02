<<<<<<< HEAD:app/models/stage_durations.rb
class StageDurations < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :duration, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end
=======
class StageDuration < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :duration, :stage_id, :user_id
  has_many :citations
  belongs_to :stage, :user
end
>>>>>>> upstream/umass_branch:app/models/stage_duration.rb

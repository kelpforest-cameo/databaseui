<<<<<<< HEAD
<<<<<<< HEAD:app/models/stage_durations.rb
class StageDurations < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :duration, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end
=======
class StageDuration < ActiveRecord::Base
=======
class Stage_Duration < ActiveRecord::Base
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
  attr_accessible :citation_id, :comment, :datum, :duration, :stage_id, :user_id
  
  has_many :citations
  belongs_to :user
  belongs_to :stage

end
>>>>>>> upstream/umass_branch:app/models/stage_duration.rb

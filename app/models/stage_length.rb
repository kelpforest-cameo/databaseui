<<<<<<< HEAD
<<<<<<< HEAD:app/models/stage_lengths.rb
class StageLengths < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :length, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end
=======
class StageLength < ActiveRecord::Base
=======
class Stage_Length < ActiveRecord::Base
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
  attr_accessible :citation_id, :comment, :datum, :length, :stage_id, :user_id
  has_many :citations
  belongs_to :stage
  belongs_to :user
end
>>>>>>> upstream/umass_branch:app/models/stage_length.rb

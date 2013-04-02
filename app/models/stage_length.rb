<<<<<<< HEAD:app/models/stage_lengths.rb
class StageLengths < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :length, :stage_id, :user_id
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
end
=======
class StageLength < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :length, :stage_id, :user_id
  has_many :citations
  belongs_to :stage, :user
end
>>>>>>> upstream/umass_branch:app/models/stage_length.rb

class StageLifestyle < ActiveRecord::Base

  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id, :project_id, :mod, :approved, :lifestyle
  belongs_to :citation
  belongs_to :stage
  belongs_to :user

end

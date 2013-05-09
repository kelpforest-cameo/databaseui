class StageLifestyle < ActiveRecord::Base
  LIFESTYLE = ["non-living","free-living","infectious"]
  enum :lifestyle, [:"non-living",:"free-living",:"infectious"]
  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id, :project_id, :mod, :approved, :lifestyle
  belongs_to :citation
  belongs_to :stage
  belongs_to :user

end

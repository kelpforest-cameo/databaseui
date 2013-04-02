class StageLifestyle < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :lifestyle, :stage_id, :user_id

belongs_to :user
end

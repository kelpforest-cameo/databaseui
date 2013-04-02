class StageResidency < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :residency, :stage_id, :user_id

belongs_to :user
end

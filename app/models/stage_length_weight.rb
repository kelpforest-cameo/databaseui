class StageLengthWeight < ActiveRecord::Base
  attr_accessible :a, :b, :citation_id, :comment, :datum, :length_weight, :stage_id, :user_id, :project_id, :mod, :approved
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
  belongs_to :project
end

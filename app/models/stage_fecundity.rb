class StageFecundity < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :fecundity, :stage_id, :user_id, :project_id, :mod, :approved
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
  belongs_to :project
end

class StageDrymass < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :drymass, :stage_id, :user_id, :project_id, :mod, :approved
  belongs_to :citation
  belongs_to :project
  belongs_to :stage
  belongs_to :user

end

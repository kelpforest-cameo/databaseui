class StageMass < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :mass, :stage_id, :user_id, :project_id, :mod, :approved
  belongs_to :citations
  belongs_to :stage
  belongs_to :user
  belongs_to :project
end

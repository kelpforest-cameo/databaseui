class StageHabitat < ActiveRecord::Base

  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id, :project_id, :mod, :approved, :habitat
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
  has_one :stage_habitat_descriptor
end


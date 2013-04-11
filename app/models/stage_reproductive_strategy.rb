class StageReproductiveStrategy < ActiveRecord::Base

  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id, :project_id, :mod, :approved, :reproductive_strategy
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
  belongs_to :project

end

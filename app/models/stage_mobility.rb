class StageMobility < ActiveRecord::Base
  MOBILITY = ['sessile','mobile','drifter']
  enum :mobility, [:'sessile',:'mobile',:'drifter']
  attr_accessible :citation_id, :comment, :datum, :stage_id, :user_id, :project_id, :mod, :approved, :mobility
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
  belongs_to :project

end

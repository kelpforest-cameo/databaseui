class StageHabitatDescriptor < ActiveRecord::Base
  attr_accessible :descriptor , :user_id, :project_id, :mod, :approved
  belongs_to :stage_habitat
  belongs_to :user
  belongs_to :project
end

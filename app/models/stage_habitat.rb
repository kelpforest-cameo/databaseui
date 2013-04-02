class StageHabitat < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :habitat, :stage_id, :user_id
  
  belongs_to :user
end

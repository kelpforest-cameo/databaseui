class Stage_Mobility < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :mobility, :stage_id, :user_id

belongs_to :user
end

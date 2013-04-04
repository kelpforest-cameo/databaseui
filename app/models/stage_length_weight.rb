class Stage_Length_Weight < ActiveRecord::Base
  attr_accessible :a, :b, :cite_id, :comment, :datum, :length_weight, :stage_id, :user_id

belongs_to :user
end

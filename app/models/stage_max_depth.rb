class Stage_Max_Depth < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :max_depth, :stage_id, :user_id
  has_many :citations
  belongs_to :stage
  belongs_to :user
end

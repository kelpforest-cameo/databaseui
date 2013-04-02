class Stage_Unassimilated_Consum_Ratio < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :stage_id, :unassimilated_consum_ratio, :user_id
  has_many :citations
  belongs_to :stage
  belongs_to :user
end

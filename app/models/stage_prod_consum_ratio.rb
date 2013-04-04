class Stage_Prod_Consum_Ratio < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :prod_consum_ratio, :stage_id, :user_id
<<<<<<< HEAD
  belongs_to :citation
=======
  has_many :citations
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
  belongs_to :stage
  belongs_to :user
end

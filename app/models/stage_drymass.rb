class Stage_Drymass < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :drymass, :stage_id, :user_id
<<<<<<< HEAD
  belongs_to :citation
  belongs_to :stage
  belongs_to :user
=======
  
  has_many :citations
  belongs_to :user
  belongs_to :stage
>>>>>>> fc2143d52fc7ef2ed4c013849c7ceab1f69c9da3
end

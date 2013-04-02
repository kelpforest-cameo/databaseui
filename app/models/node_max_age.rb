<<<<<<< HEAD:app/models/node_max_ages.rb
class NodeMaxAges < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :max_age, :node_id, :user_id
  belongs_to :citation
  belongs_to :node
  belongs_to :user
end
=======
class Node_Max_Age < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :max_age, :node_id, :user_id
	belongs_to :user
end
>>>>>>> upstream/umass_branch:app/models/node_max_age.rb

class NodeRanges < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :location_n_id, :location_s_id, :node_id, :user_id
  belongs_to :citation
  belongs_to :node
  belongs_to :user
end

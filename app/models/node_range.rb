class Node_Range < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :location_n_id, :location_s_id, :node_id, :user_id
  has_many :citations
  belongs_to :node
  belongs_to :user
end

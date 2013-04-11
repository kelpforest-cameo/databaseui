class NodeRange < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :location_n_id, :location_s_id, :node_id, :user_id, :project_id, :mod, :approved
  belongs_to :citations
  belongs_to :node
  belongs_to :user
  belongs_to :project
  
end

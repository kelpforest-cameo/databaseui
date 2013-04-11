class NodeMaxAge < ActiveRecord::Base
  attr_accessible :citation_id, :comment, :datum, :max_age, :node_id, :user_id, :project_id, :mod, :approved
  belongs_to :citation
  belongs_to :project
  belongs_to :node
  belongs_to :user
end

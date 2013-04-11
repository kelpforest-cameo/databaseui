class NonIti < ActiveRecord::Base
  attr_accessible :info, :latin_name, :parent_id, :parent_id_is_itis, :taxonomy_level, :user_id, :project_id, :mod, :approved
  belongs_to :node
  belongs_to :project
  belongs_to :user
end

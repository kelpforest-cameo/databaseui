class Location < ActiveRecord::Base
  attr_accessible :active, :lft, :name, :parent, :rgt, :visible, :z_index, :zoom_max, :zoom_min, :user_id, :project_id, :mod
belongs_to :user
belongs_to :project

end

class FunctionalGroup < ActiveRecord::Base
  attr_accessible :name, :project_id, :user_id, :mod, :approved
  has_many :nodes
  belongs_to :project_id
end

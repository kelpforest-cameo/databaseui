class Node < ActiveRecord::Base
  attr_accessible :functional_group_id, :is_assemblage, :itis_id, :non_itis_id, :user_id, :working_name, :project_id, :mod, :approved
  belongs_to :functional_group
  belongs_to :user
  belongs_to :project
  #has_one :non_itis, :dependent => :destroy  
end

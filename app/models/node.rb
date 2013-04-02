class Node < ActiveRecord::Base
  attr_accessible :functional_group_id, :is_assemblage, :itis_id, :native_status, :non_itis_id, :user_id, :working_name
belongs_to :user
end

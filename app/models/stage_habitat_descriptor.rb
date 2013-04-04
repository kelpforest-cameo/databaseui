class Stage_Habitat_Descriptor < ActiveRecord::Base
  attr_accessible :descriptor , :user_id
  
  belongs_to :user
end

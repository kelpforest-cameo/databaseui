class StageConsumerStrategy < ActiveRecord::Base
  CONSUMERSTRATEGY = ['autotroph','grazer','filterfeeder','passive sit','active cursorial','detritivore','scavenger']
  enum :consumer_strategy, [:'autotroph',:'grazer',:'filterfeeder',:'passive sit',:'active cursorial',:'detritivore',:'scavenger']
  attr_accessible :citation_id, :comment, :consumer_strategy, :datum, :stage_id, :user_id, :project_id, :mod, :approved
  belongs_to :citation
  belongs_to :stage
  belongs_to :project
  belongs_to :user
end

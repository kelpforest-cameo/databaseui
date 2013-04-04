class Stage_Consumer_Strategy < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :consumer_strategy, :datum, :stage_id, :user_id
belongs_to :user
end

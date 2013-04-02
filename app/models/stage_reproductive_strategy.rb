class StageReproductiveStrategy < ActiveRecord::Base
  attr_accessible :cite_id, :comment, :datum, :reproductive_strategy, :stage_id, :user_id

belongs_to :user
end

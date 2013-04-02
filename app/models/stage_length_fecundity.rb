class StageLengthFecundity < ActiveRecord::Base
  attr_accessible :a, :b, :cite_id, :comment, :datum, :length_fecundity, :stage_id, :user_id
belongs_to :user
end

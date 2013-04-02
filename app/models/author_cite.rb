class AuthorCite < ActiveRecord::Base
  attr_accessible :author_id, :cite_id, :user_id
  belongs_to :user
end

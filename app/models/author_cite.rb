# Middle-man to link authors and their corresponding citations
class AuthorCite < ActiveRecord::Base
  attr_accessible :author_id, :citation_id, :user_id, :project_id, :mod , :approved
  belongs_to :author
  belongs_to :user
  belongs_to :project
  belongs_to :citation
end

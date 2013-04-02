<<<<<<< HEAD
# Middle-man to link authors and their corresponding citations
class AuthorCite < ActiveRecord::Base
  attr_accessible :author_id, :citation_id, :user_id
  belongs_to :author, :citation, :user
=======
class Author_Cite < ActiveRecord::Base
  attr_accessible :author_id, :cite_id, :user_id
  belongs_to :user
>>>>>>> upstream/umass_branch
end

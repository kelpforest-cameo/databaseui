<<<<<<< HEAD:app/models/authors.rb
class Authors < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id
  belongs_to :user
  has_many :author_cites
  has_many :citations, :through => :author_cites
end
=======
class Author < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id
  belongs_to :user
  belongs_to :author_cite, :dependent => :destroy
end
>>>>>>> upstream/umass_branch:app/models/author.rb

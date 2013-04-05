class Citation < ActiveRecord::Base
  attr_accessible :abstract, :closed, :document, :format, :format_title, :number, :pages, :publisher, :title, :user_id, :volume, :year, :mod, :project_id, :approved
  belongs_to :user
  belongs_to :project
  has_many :author_cites
  has_many :authors, :through => :author_cites
end

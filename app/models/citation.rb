class Citation < ActiveRecord::Base
  attr_accessible :abstract, :closed, :document, :format, :format_title, :number, :pages, :publisher, :title, :user_id, :volume, :year
end

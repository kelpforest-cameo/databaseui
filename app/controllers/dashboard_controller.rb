class DashboardController < ApplicationController
 
  def index
  end
  
  def dataentry
  @author = Author.new
  @authorlist = Author.all
  @citation = Citation.new
  @citationlist = Citation.all
  end

  
end

class DashboardController < ApplicationController

  def index
  end
  
  def dataentry
  @author = Author.new
  @citation = Citation.new
  @citationlist = Citation.all
  end

  
end

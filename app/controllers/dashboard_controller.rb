class DashboardController < ApplicationController
  load_and_authorize_resource :only => [:show, :update, :destroy]
  def index
  end
  def dataentry
  @author = Author.new
  authorize! :create, @author
  respond_to do |format|
  	format.html
  	format.json {render json: @authors}
  	end
  @citation = Citation.new
  authorize! :create, @citation
  respond_to do|format|
  	format.html
  	format.json {render json @citations}
  	end
  	
  @citationlist = Citation.all
  end

    rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end

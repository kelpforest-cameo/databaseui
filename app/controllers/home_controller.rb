class HomeController < ApplicationController
	skip_load_and_authorize_resource
	 skip_before_filter :authenticate_user!
  def index
    counter = 0
    LocationData.find_each do |location|
    
    @polygons = Array.new(LocationData.count,Array.new)

    location.latitude.each_index do |index|
    @polygons[counter] << { :lat => location.latitude[index], :lng =>location.longitude[index]}
    end
    counter = counter + 1
        end
    
    
    @polygons = @polygons.to_json
    respond_to do |format|
    format.html
    format.json { render json: @polygons }   
    
  end
end
end

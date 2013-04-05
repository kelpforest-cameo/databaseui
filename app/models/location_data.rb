class LocationData < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => false
  attr_accessible :latitude,:longitude, :location_id,:name , :user_id, :project_id, :mod
  belongs_to :location
  belongs_to :user
  belongs_to :project
  def gmaps4rails_address
    "#{name}"
  end
end

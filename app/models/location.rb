class Location < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :name, :state, :latitude, :longitude, :population

  def gmaps4rails_address
    "#{name}, #{state}"
  end
end

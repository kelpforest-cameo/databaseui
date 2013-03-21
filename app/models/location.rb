class Location < ActiveRecord::Base
  attr_accessible :name, :state, :latitude, :longitude, :gmaps, :population
  acts_as_gmappable

  def gmaps4rails_address
  	"#{self.name}, #{self.state}"
  end
end

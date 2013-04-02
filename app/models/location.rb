class Location < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :name, :state, :latitude, :longitude, :population
  has_many :location_data, :dependent => :destroy

  def gmaps4rails_address
    "#{name}, #{state}"
  end
end

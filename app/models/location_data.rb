class Location_Data < ActiveRecord::Base
  attr_accessible :lat, :location_id, :lon
  belongs_to :location
  belongs_to :user
end

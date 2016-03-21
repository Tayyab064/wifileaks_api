class Wifi < ActiveRecord::Base
	belongs_to :user
	geocoded_by :address, :latitude  => :lat, :longitude => :long

end

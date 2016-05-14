class Connection < ActiveRecord::Base
	belongs_to :wifi
	belongs_to :user

	has_one :rating

	validates_presence_of :connected_at , :disconnected_at , :download_data
end

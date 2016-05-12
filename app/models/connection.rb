class Connection < ActiveRecord::Base
	belongs_to :wifi
	belongs_to :user
end

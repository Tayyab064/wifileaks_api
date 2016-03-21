class WifisController < ApplicationController
	before_filter :restrict_access

	def index
		@wifis = @current_user.wifis
		render json: @wifis
	end

	def near_wifis
		@wifis = Wifi.near([params[:lat],params[:long]] , 20, :units => :km)
		render json: @wifis
	end
end

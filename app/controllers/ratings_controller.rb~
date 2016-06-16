class RatingsController < ApplicationController
	before_filter :restrict_access

	def create
		if Connection.find(params[:rating][:connection_id]).rating.nil?
			if @rating = Rating.create(rating_params)
				render json: {'message' => 'Connection rated!'} , status: :ok
			else
				render json: @rating.errors , status: :unprocessable_entity
			end
		else
			render json: {'message' => 'Connection already rated!'} , status: :unprocessable_entity
		end
	end

	def index
		if wifi = @current_user.wifis.find(params[:wifi_id])
			rating = wifi.connections
			render json: rating , status: :ok
		else
			render json: {'message' => 'Invalid wifi url'} , status: :unprocessable_entity
		end
	end

	private
	def rating_params
		params.require(:rating).permit(:rate , :connection_id)
	end
end

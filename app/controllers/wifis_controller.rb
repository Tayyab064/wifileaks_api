class WifisController < ApplicationController
	before_filter :restrict_access

	def index
		@wifis = @current_user.wifis
		render json: @wifis , status: :ok
	end

	def create
		@wifi = Wifi.new(wifi_params)
		@wifi.user_id = @current_user.id
		if @wifi.save
			render json: @wifi , status: :created
		else
			render json: @wifi.errors , status: :unprocessable_entity
		end
	end

	def update
		if @wifi = @current_user.wifis.find(params[:id])
			@wifi.update(wifi_update_params)
		  	render json: @wifi, status: :accepted
		else
		  	render json: @wifi.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@wifi = @current_user.wifis.find(params[:id])
		@wifi.destroy
		head :no_content
	end

	def near_wifis
		@wifis = Wifi.near([params[:lat],params[:long]] , 20, :units => :km)
		render json: @wifis
	end

	def search
		if params[:atn].present?
			render json: {'message' => 'Phr kbhi kare ge!'} , status: :ok
		else
			render json: {'message' => 'Params missing!'} , status: :unprocessable_entity
		end
	end


	private
	def wifi_params
		params.require(:wifi).permit(:name , :address , :lat , :long , :password , :ssid , :security_type , :price , :avg_speed)
	end

	def wifi_update_params
		params.require(:wifi).permit(:name , :password , :price , :avg_speed)
	end
end
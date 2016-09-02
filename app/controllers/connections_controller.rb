class ConnectionsController < ApplicationController
	before_filter :restrict_access
	before_action :set_connection , only: [:destroy , :rate , :update]

	def index
		@connect = @current_user.connections
		render json: @connect , status: :ok
	end

	def create
		@connection = Connection.create(connection_params)
		@connection.user_id = @current_user.id
		if @connection.save
			@current_user.update(:terminated_successfully => false)
			render json: @connection ,  status: :created
		else
			render json: @connection.errors , status: :unprocessable_entity
		end
	end

	def update
		p params
		@connect.update(connection_update_params)
		bil = ((@connect.download_data * @connect.wifi.price)/100).round(2)
		@connect.update(total_bill: bil)
		@current_user.update(terminated_successfully: true)
		render json: @connect , status: :ok
	end

	/def destroy
		if @connect.disconnected_at.nil? && params[:download_data].present?
			if params[:upload_data].present?
				upload_data = params[:upload_data]
			else
				upload_data = 0.0
			end
			@connect.update(disconnected_at: Time.now , download_data: params[:data])
		end
		render json: @connect  , status: :ok
	end

	def rate
		if params[:rating].present?
			if params[:rating].to_i >= 1 && params[:rating].to_i <= 5
				@connect.update(rating: params[:rating])
				render json: {'message' => 'Successfully rated!'} , status: :ok
			else
				render json: {'message' => 'Invalid rating param!'} , status: :unprocessable_entity
			end
		else
			render json: {'message' => 'Params are missing!'} , status: :unprocessable_entity
		end
	end/

	private
	def connection_params
		params.require(:connection).permit(:wifi_id , :connected_at)
	end

	def connection_update_params
		params.require(:connection).permit(:download_data , :upload_data , :disconnected_at)
	end

	def set_connection
		@connect = @current_user.connections.find(params[:id])
	end
end

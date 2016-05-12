class ConnectionsController < ApplicationController
	before_filter :restrict_access
	before_action :set_connection , only: [:destroy , :rate]

	def index
		@connect = @current_user.connections
		render json: @connect , status: :ok
	end

	def create
		@connection = Connection.create(connection_params)
		@connection.user_id = @current_user.id
		if @connection.save
			render json: @connection , serializer: ConnectionBillSerializer , status: :created
		else
			render json: @connection.errors , status: :unprocessable_entity
		end
	end

	def destroy
		if @connect.disconnected_at.nil? && params[:data].present?
			@connect.update(disconnected_at: Time.now , data: params[:data])
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
	end

	private
	def connection_params
		params.require(:connection).permit(:wifi_id)
	end

	def set_connection
		@connect = @current_user.connections.find(params[:id])
	end
end

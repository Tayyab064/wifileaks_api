class BankInformationController < ApplicationController
	before_filter :restrict_access

	def index
		if @current_user.bank_information.present?
			render json:@current_user.bank_information  , status: :ok
		else
			render json: {'message' => 'Bank Information Missing'} , status: :unprocessable_entity
		end
	end

	def create
		if @current_user.bank_information.nil?
			@bankinfo = BankInformation.new(bankinfo_params)
			@bankinfo.user_id = @current_user.id
			if @bankinfo.save
				render json: @bankinfo , status: :created
			else
				render json: @bankinfo.errors , status: :unprocessable_entity
			end
		else
			render json: {'message' => 'Bank Information Already Defined!'} , status: :unprocessable_entity
		end
	end

	def update
		if @current_user.bank_information.present?
			@bankinfo = @current_user.bank_information
			@bankinfo.update(bankinfo_params)
			render json: {'message' => 'Bank Information Successfully Updated!'} , status: :accepted
		else
			render json: {'message' => 'Bank Information not present!'} , status: :unprocessable_entity
		end
	end

	private
	def bankinfo_params
		params.require(:bank_information).permit(:currency , :country , :name , :routing_number , :account_number)
	end
end

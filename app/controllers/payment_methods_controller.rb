class PaymentMethodsController < ApplicationController
	before_filter :restrict_access

	def index
		if @current_user.payment_method.present?
			render json: {'message' => 'Payment Method Present!'} , status: :ok
		else
			render json: {'message' => 'Payment Method Missing'} , status: :unprocessable_entity
		end
	end

	def create
		if @current_user.payment_method.nil?
			@payment_method = PaymentMethod.new(payment_params)
			@payment_method.user_id = @current_user.id
			if @payment_method.save
				render json: {'message' => 'Payment Method Successfully Created!'} , status: :created
			else
				render json: @payment_method.errors , status: :unprocessable_entity
			end
		else
			render json: {'message' => 'Payment Method Already Defined!'} , status: :unprocessable_entity
		end
	end

	def update
		if @current_user.payment_method.present?
			@payment_method = @current_user.payment_method
			@payment_method.update(payment_params)
			render json: {'message' => 'Payment Method Successfully Updated!'} , status: :accepted
		else
			render json: {'message' => 'Payment Method not present!'} , status: :unprocessable_entity
		end
	end

	private
	def payment_params
		params.require(:payment_method).permit(:card_number , :expiry , :cvn)
	end
end

class AmountWithdrawController < ApplicationController
	before_filter :restrict_access

	def return_amount
		if @current_user.amount.present?
			render json: {'amount' => @current_user.amount.amount.to_s } , status: :ok
		else
			render json: {'message' => 'Amount not present' } , status: :unprocessable_entity
		end
	end
end

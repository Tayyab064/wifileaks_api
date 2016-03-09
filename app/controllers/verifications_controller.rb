class VerificationsController < ApplicationController
	before_filter :restrict_access

	def verify
	    if current_user.mob_verification_code == params[:verification_code]
			current_user.number_verified = true
			current_user.mob_verification_code.destroy
			current_user.save
			render json: 'Thank you for verifying your mobile number.',status: 200
			return
	    else
			render json: 'Invalid verification code.',status: 401
			return
	    end
	end
end

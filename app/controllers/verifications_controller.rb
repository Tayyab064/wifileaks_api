class VerificationsController < ApplicationController
	#before_filter :restrict_access

	def mobile
		p params.inspect
		if token = Verification.find_by_mob_verification_code(params[:mobile_token])
			token.user.number_verified = true
			token.user.save
			token.destroy
			render json: 'Thank you for verifying your mobile number.',status: 200
			return
	    else
			render json: 'Invalid verification code',status: 401
			return
	    end
	end

#Todo: Serialization
#Sms
#background jobs
#fogfot pass
#email templete

	def email
			if token = Verification.find_by_email_token(params[:email_token])
				if token.user
					token.user.email_verified = true
					token.email_token = " "
					token.user.save
					token.save
					render json:'Thank you for verifying your email.',status: 200
				end
			else
				render json: {'message' => 'Sorry, unauthorized token.'},status: 401
			end
		end


end

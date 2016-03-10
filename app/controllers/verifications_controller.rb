class VerificationsController < ApplicationController
	before_filter :restrict_access, except: [:email]

	def mobile_verify
		p params.inspect
		if token = Verification.find_by_mob_verification_code(params[:mobile_token])
			token.user.number_verified = true
			token.user.save
			token.destroy
			render json:{'message' => 'Thank you for verifying your mobile number.'},status: :ok
			return
	    else
			render json:{'message' => 'Invalid mobile verification code.'},status: :unauthorized
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
				render json:{'message' => 'Thank you for verifying your email.'},status: :ok
			end
		else
			render json: {'message' => 'Invalid email verification token.'},status: :unauthorized
		end
	end

	def mobile_generate
		@current_user.verification.mob_verification_code =  1_000_000 + rand(10_000_000 - 1_000_000)
		@current_user.mobile_number = params[:mobile_number]
	  	@current_user.save

		to = @current_user.mobile_number


		account_sid = 'AC89e76904587c00d004e844faed1a3962' 
		auth_token = 'c17364061e4f9e0ef54b2a688a07d982' 

		@twilio_client = Twilio::REST::Client.new account_sid, auth_token
		@twilio_client.account.sms.messages.create(
		:from => "+12019774712", #TODO: change this number
		:to => to,
		:body => "Your verification code is #{@current_user.verification.mob_verification_code}."
		)
		render :json @current_user
		return
		#end of mobile
	end


end

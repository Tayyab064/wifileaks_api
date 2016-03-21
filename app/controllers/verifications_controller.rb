class VerificationsController < ApplicationController
	before_filter :restrict_access, except: [:email ,:reset_password]

	def mobile_verify
		p params.inspect
		if token = Verification.find_by_mob_verification_code(params[:mobile_token])
			user = token.user
			user.update_attribute(:number_verified, true)
			token.destroy
			render json:{'message' => 'Thank you for verifying your mobile number.'},status: :ok
			#render html: '<h3 style="text-align: center">Thank you for verifying your mobile number.</h3>'
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
#verify/mobile

	def email
		if token = Verification.find_by_email_token(params[:email_token])
			if token.user
				#token.user.email_verified = true
				token.email_token = nil
				token.user.update_attribute(:email_verified, true)
				token.save
				#render json:{'message' => 'Thank you for verifying your email.'},status: :ok
				#render html: '<h3 style="text-align=center">Thank you for verifying your email.</h3>'.html_safe, status: :ok
				redirect_to '/email_confirmation.html'
			end
		else
			render json: {'message' => 'Invalid email verification token.'},status: :unauthorized
		end
	end

	def mobile_generate
		
		@mob_number = params[:mobile_number]
		if @current_user.number_verified
			render json: {'message' => "Mobile number already verified"}, status: :ok
	  	else
			@current_user.update_attribute(:mobile_number,@mob_number)
	  		verification = @current_user.verification
			verification.mob_verification_code = 1_000_000 + rand(10_000_000 - 1_000_000)
			verification.save

	  	

			to = @current_user.mobile_number


			account_sid = 'AC89e76904587c00d004e844faed1a3962' 
			auth_token = 'c17364061e4f9e0ef54b2a688a07d982' 

			@twilio_client = Twilio::REST::Client.new account_sid, auth_token
			@twilio_client.account.sms.messages.create(
			:from => "+12019774712", #TODO: change this number
			:to => to,
			:body => "Your verification code is #{@current_user.verification.mob_verification_code}."
			)
			render json: @current_user
			return
		#end of mobile
	  	end
	end

	def resend_email_confirmation
		if @user = @current_user
			if @user.email_verified == true
				render json: {'message' => "Email already verified"}, status: :ok
			else
				render json: {'message' => "Sending Email"}, status: :ok
				UserMailer.registration_confirmation(@user).deliver_later
			end
	    end
	end

	def reset_password
		if token = Verification.find_by_forgot_password_token(params[:forgot_password_token])
			@user = token.user
			redirect_to '/reset_password.html'
		else
			render json: {'message' => "Invalid forgot password token"}, status: :unauthorized
		end
	end

end

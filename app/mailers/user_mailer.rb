class UserMailer < ApplicationMailer
	def registration_confirmation(user)
		@user = user
    	@url  = 'https://wifi-api.herokuapp.com'
    	mail(to: @user.email, subject: 'WifiExplore' )
	end

	def reset_password(user)
		@user = user
    	@url  = 'https://wifi-api.herokuapp.com'
    	mail(to: @user.email, subject: 'WifiExplore', body: 'Welcome again '+ @user.first_name + '. Please click on link to reset password: https://wifi-api.herokuapp.com/user/reset_password/'+ @user.verification.forgot_password_token )
	end

	def reset_password_temp(user)
		@user = user
    	@url  = 'https://wifi-api.herokuapp.com'
    	mail(to: @user.email, subject: 'WifiExplore' )
	end

	def mobile_confirmation(user)
		user = user
    	url  = 'https://wifi-api.herokuapp.com'
    	mail(to: user.email, subject: 'WifiExplore' )
	end

	def connection_finished(user , conn)
		user = user
		@conne = conn
    	url  = 'https://wifi-api.herokuapp.com'
    	mail(to: user.email, subject: 'WifiExplore' )
	end
end

#https://wifi-api.herokuapp.com/user/verify/email/'+ @user.verification.email_token
#{:email => @user.verification.email_token, :url => "https://wifi-api.herokuapp.com/email_confirmation.html"}
#, body: '<%= render template: "email_confirmation.html" %>'
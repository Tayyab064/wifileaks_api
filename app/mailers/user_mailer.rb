class UserMailer < ApplicationMailer
	def registration_confirmation(user)
		@user = user
    	@url  = 'https://wifi-api.herokuapp.com'
    	mail(to: @user.email, subject: 'WifiExplore', body: 'Welcome '+ @user.first_name + '. Please click on link to confirm email: https://wifi-api.herokuapp.com/user/verify/email/'+ @user.verification.email_token )
	end

	def reset_password(user)
		@user = user
    	@url  = 'https://wifi-api.herokuapp.com'
    	mail(to: @user.email, subject: 'WifiExplore', body: 'Welcome again '+ @user.first_name + '. Please click on link to reset password: https://wifi-api.herokuapp.com/user/reset_password/'+ @user.verification.forgot_password_token )
	end
end

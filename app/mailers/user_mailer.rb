class UserMailer < ApplicationMailer
	def registration_confirmation(user)
		@user = user
    	@url  = 'https://wifi-api.herokuapp.com'
    	mail(to: @user.email, subject: 'WifiExplore', body: 'Welcome '+ @user.first_name + '. Please click to confirm email: https://wifi-api.herokuapp.com/verify/email/'+ @user.verification.email_token )
	end
end

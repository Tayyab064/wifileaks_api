class UserMailer < ApplicationMailer
	def registration_confirmation(user)
		@user = user
    	@url  = 'https://wifi-api.herokuapp.com'
    	mail(to: @user.email, subject: 'WifiExplore', body: 'Welcome '+@user.last_name + '. Please click to confirm email: <a href="http://localhost:3000/confirm_email/'+ @user.verification.email_token + '">confirm</a>' )
	end
end

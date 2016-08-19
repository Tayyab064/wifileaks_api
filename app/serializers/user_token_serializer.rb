class UserTokenSerializer < ActiveModel::Serializer
  	attributes  :first_name ,:last_name , :email ,:mobile_number, :email_verified , :number_verified , :terminated_successfully ,:token

	def token
		object.api_key.token
	end

end

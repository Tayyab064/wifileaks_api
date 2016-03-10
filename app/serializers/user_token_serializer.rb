class UserTokenSerializer < ActiveModel::Serializer
  	attributes  :first_name ,:last_name , :email ,:mobile_number, :email_verified , :number_verified,:token

	def token
		object.api_key.token
	end
end

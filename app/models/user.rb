class User < ActiveRecord::Base
	has_secure_password

	has_one :api_key, dependent: :destroy
	has_one :verification, dependent: :destroy

	#scope :is_email_verified, where(email_verified: true)
	#scope :is_number_verified, where(number_verified: true)

	after_create :create_tokens

	##Validation
	validates_presence_of :first_name,:last_name,:email, :mobile_number
	validates_uniqueness_of :email
	validates :first_name ,:last_name, length: {within: 2..15}
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }



	def create_tokens
	  	ApiKey.create :user => self
	  	Verification.create :user => self
	end

	
end
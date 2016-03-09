class Verification < ActiveRecord::Base
  belongs_to :user

  before_create :generate_email_code

  private

  def generate_email_code
  	begin
      self.email_token = SecureRandom.hex.to_s
    end while self.class.exists?(email_token: email_token)
  end

  def generate_mobile_code
  	begin
  		self.mob_verification_code = 1_000_000 + rand(10_000_000 - 1_000_000)
  	end while self.class.exists?(mob_verification_code: mob_verification_code) 
  end
  
end

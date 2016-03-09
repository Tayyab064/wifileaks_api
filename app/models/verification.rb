class Verification < ActiveRecord::Base
  belongs_to :user

  before_create :generate_verification_codes

  private

  def generate_verification_codes
  	begin
      self.email_token = SecureRandom.hex.to_s
      self.mob_verification_code =  1_000_000 + rand(10_000_000 - 1_000_000)
    end while self.class.exists?(email_token: email_token , mob_verification_code: mob_verification_code)
  end
end

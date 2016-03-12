class AddForgotPasswordTokenToVerification < ActiveRecord::Migration
  def change
  	add_column :verifications , :forgot_password_token ,:string
  end
end

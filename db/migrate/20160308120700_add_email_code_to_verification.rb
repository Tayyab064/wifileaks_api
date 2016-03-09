class AddEmailCodeToVerification < ActiveRecord::Migration
  def change
  	add_column :verifications , :email_token ,:string
  	rename_column :verifications , :verification_code , :mob_verification_code
  end
end

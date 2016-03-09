class UsersController < ApplicationController
	before_filter :restrict_access, except: [:create,:verify_email]

	def index
	render json: @current_user, except: :password_digest
	end

	def create
	@user = User.new(user_params)

	if @user.save
	  UserMailer.registration_confirmation(@user).deliver_later
	  render json: @user.api_key.token.to_json, status: :created
	else
	  render json: @user.errors, status: :unprocessable_entity
	end
	end

	def update
	@user = @current_user

	if @user.update(user_params)
	  render json: @user, status: :accepted
	else
	  render json: @user.errors, status: :unprocessable_entity
	end
	end

	def verify_email
		if token = Verification.find_by_email_token(params[:token])
			if token.user
				token.user.email_verified = true
				token.email_token = " "
				token.user.save
				token.save
				render json:'Thank you for verifying your email.',status: 200
			end
		else
			render json:'Sorry, unauthorized token.',status: 401
		end
	end

	def destroy
	@user = @current_user
	@user.destroy
	head :no_content
	end

	private
	  def user_params
	    params.require(:user).permit(:first_name,:last_name, :email,:mobile_number, :password,
	                                 :password_confirmation)
	  end
end

class UsersController < ApplicationController
	before_filter :restrict_access, except: [:create]

	def index
		render json: @current_user
	end

	def create
		@user = User.new(user_params)

		#background jobs
		if @user.save
			render json: @user, serializer: UserTokenSerializer, status: :created
		  	UserMailer.registration_confirmation(@user).deliver_later
		else
		  	render json: @user.errors, status: :unprocessable_entity
		end
	end

	def update
		@user = @current_user

		if @user.update(user_update_params)
		  render json: @user, status: :accepted
		else
		  render json: @user.errors, status: :unprocessable_entity
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

	  def user_update_params
	    params.require(:user).permit(:first_name,:last_name,:mobile_number, :password,
	                                 :password_confirmation)
	  end
end

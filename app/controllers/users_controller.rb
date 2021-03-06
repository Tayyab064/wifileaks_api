class UsersController < ApplicationController
	before_filter :restrict_access, except: [:create , :update_password]

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

	def termin_successfully
		@user = @current_user
		if @user.update(terminated_successfully: true)
		  render json: @user, serializer: UserTokenSerializer , status: :accepted
		else
		  render json: @user.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@user = @current_user
		@user.destroy
		head :no_content
	end

	def wifi_user
		wifi = @current_user.wifis.find(params[:id])
		h = Array.new
		count = 0
		wifi.connections.each do |conn|
			if conn.rating.present?
				ratin = conn.rating.rate
			else
				ratin = 0
			end
			name = conn.user.first_name + " " + conn.user.last_name
			h.push({'name' => name , 'rating' => ratin , 'bill' => conn.total_bill , 'picture' => conn.user.picture })	
			count = count + 1
		end
		render json: h , status: :ok
	end

	def set_picture
		if params[:picture].present?
			user = @current_user
			user.update(picture: params[:picture])
			render json: user , status: :ok
		else
			render json: {'message' => 'Picture Missing!'} , status: :unprocessable_entity
		end
	end

	def update_password
		p params
		if params[:token].present?
			veri = Verification.where(forgot_password_token: params[:token])
			if veri.count > 0
				user = veri.first.user
				user.update(password: params[:password])
				veri.first.update(forgot_password_token: nil)
				render json: {'message' => 'Password Successfully updated' } , status: :ok
			else
				render json: {'message' => "Invalid reset password token" } , status: :unauthorized
			end
		else
			render json: {'message' => "Invalid reset password token" } , status: :unauthorized
		end
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

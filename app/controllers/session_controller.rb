class SessionController < ApplicationController
  before_filter :restrict_access, only: [:destroy ]

  def create

    if  user=User.find_by_email(params[:email])
      if user.authenticate(params[:password])
        @current_user = user
        @current_user.create_api_key
        render json: @current_user,serializer: UserTokenSerializer, status: :ok
      else
        render json:{'error' => "Password issue"}, status: :unauthorized
      end
    else
      render json:{'error' => "User doesn't exists"}, status: :unauthorized
      #render html: "User doesn't exists".html_safe, status: :unauthorized
    end
    #  render json: @current_user.to_json
  end


  def destroy

    @current_user.api_key.destroy
    head :no_content

  end

  def forgot_password
    if @user = User.find_by_email(params[:email])
      current_user = @user.verification
      begin
        password_token = SecureRandom.hex.to_s
        current_user.forgot_password_token = password_token
      end while current_user.class.exists?(forgot_password_token: password_token)
      current_user.save
      UserMailer.reset_password(@user).deliver_later
    else
      render json: {'error' => "Invalid email"}, status: :unauthorized
    end
  end
end
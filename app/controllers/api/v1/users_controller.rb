class Api::V1::UsersController < ApplicationController

  def create
    if user_params[:password] == user_params[:password_confirmation]
      new_user = User.new(user_params)
      if new_user.save
        new_user.update(api_key: SecureRandom.hex)
        render json: UserSerializer.new(new_user), status: 201
      else
        render json: {}
      end
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end

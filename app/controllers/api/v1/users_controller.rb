class Api::V1::UsersController < ApplicationController
  before_action :check_passwords

  def create
    new_user = User.new(user_params)
    if new_user.save
      new_user.update(api_key: SecureRandom.hex)
      render json: UserSerializer.new(new_user), status: 201
    else
      render json: { error: 'Email entered is unavailable'}, status: 401
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def check_passwords
    if user_params[:password] != user_params[:password_confirmation]
      render json: { error: "Password does not match password confirmation" }, status: 401
    elsif
      user_params[:password] == "" || user_params[:password_confirmation] == ""
      render json: { error: "Missing a password field" }, status: 401
    end
  end
end

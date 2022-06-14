class Api::V1::SessionsController < ApplicationController
  before_action :check_email

  def index
    user = User.find_by(email: session_params[:email]).authenticate(session_params[:password])
    if user
      render json: UserSerializer.new(user)
    else
      render json: { error: 'Invalid credentials'}, status: 401
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end

  def check_email
    if session_params[:email] == ""
      render json: { error: "Missing Field"}, status: 401
    end
  end
end

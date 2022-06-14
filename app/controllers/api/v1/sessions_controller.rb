class Api::V1::SessionsController < ApplicationController
  before_action :check_fields

  def index
    found_user = User.find_by(email: session_params[:email])
    if found_user
      user = found_user.authenticate(session_params[:password])
      if user
        render json: UserSerializer.new(user)
      else
        render json: { error: 'Invalid credentials'}, status: 401
      end
    else
      render json: { error: 'Invalid credentials'}, status: 401
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end

  def check_fields
    if session_params[:email] == "" || session_params[:password] == ""
      render json: { error: "Missing Field"}, status: 401
    end
  end
end

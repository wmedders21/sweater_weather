class Api::V1::SessionsController < ApplicationController

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
end

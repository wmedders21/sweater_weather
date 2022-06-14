class Api::V1::RoadTripController < ApplicationController
  before_action :verify

  def index
    road_trip = RoadTripFacade.get_roadtrip(road_trip_params)
    render json: RoadTripSerializer.new(road_trip)
  end

  private

  def road_trip_params
    params.permit(:origin, :destination)
  end

  def verify
    unless User.find_by(api_key: params[:api_key])
      render json: { error: 'Invalid Key' }, status: 401
    end
  end
end

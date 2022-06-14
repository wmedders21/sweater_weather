class Api::V1::RoadTripController < ApplicationController
  before_action :verify
  before_action :check_fields

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

  def check_fields
    if road_trip_params[:origin] == "" || road_trip_params[:destination] == ""
      render json: { error: 'Missing Field' }, status: 401
    elsif !road_trip_params[:origin] || !road_trip_params[:destination]
      render json: { error: 'Missing Field' }, status: 401
    end
  end      
end

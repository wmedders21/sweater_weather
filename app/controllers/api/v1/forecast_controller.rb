class Api::V1::ForecastController < ApplicationController

  def index
    location = LocationFacade.get_location(forecast_params[:location])
  end

  private

  def forecast_params
    params.permit :location
  end
end

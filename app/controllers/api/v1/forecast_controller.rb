class Api::V1::ForecastController < ApplicationController

  def index
    location = LocationFacade.get_location(forecast_params[:location])
    forecast = WeatherFacade.get_forecast(location)
    render json:  ForecastSerializer.new(forecast)
  end

  private

  def forecast_params
    params.permit :location
  end
end

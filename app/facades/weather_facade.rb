class WeatherFacade
  #
  # def self.get_current_weather(location)
  #   response = OpenWeatherService.get_forecast(location)
  #   forecast_data = response[:current]
  #   CurrentWeather.new(forecast_data)
  # end
  #
  # def self.get_daily_weather(location)
  #   response = OpenWeatherService.get_forecast(location)
  #   forecast_array = response[:daily].take(5)
  #   forecast_array.map do |daily_stats|
  #     DailyWeather.new(daily_stats)
  #   end
  # end
  #
  # def self.get_hourly_weather(location)
  #   response = OpenWeatherService.get_forecast(location)
  #   forecast_array = response[:hourly].take(8)
  #   forecast_array.map do |hourly_stats|
  #     HourlyWeather.new(hourly_stats)
  #   end
  # end

  def self.get_forecast(location)
    response = OpenWeatherService.get_forecast(location)
    forecast = {}
    forecast[:current_weather] = CurrentWeather.new(response[:current])
    daily_array = response[:daily].take(5)
    forecast[:daily_weather] = daily_array.map { |daily_stats| DailyWeather.new(daily_stats) }
    hourly_array = response[:hourly].take(8)
    forecast[:hourly_weather] = hourly_array.map { |hourly_stats| HourlyWeather.new(hourly_stats) }
    Forecast.new(forecast)
  end
end

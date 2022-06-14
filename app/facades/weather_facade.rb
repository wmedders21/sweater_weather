class WeatherFacade

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

class OpenWeatherService < BaseService
  @url = "http://api.openweathermap.org/data/2.5/"

  def self.get_forecast(location)
    get_json(conn(@url, 'appid', ENV['open_weather_key']).get("onecall?lat=#{location.lat}&lon=#{location.lon}&units=imperial&exclude=minutely,alerts"))
  end
end

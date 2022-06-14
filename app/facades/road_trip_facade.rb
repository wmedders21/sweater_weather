class RoadTripFacade

  def self.get_roadtrip(params)
    response = MapquestService.trip(params)
    coords = response[:route][:locations].last[:latLng]
    travel_time = ActiveSupport::Duration.build(response[:route][:time]).parts
    location = Location.new(coords)
    weather = OpenWeatherService.get_forecast(location)
    weather_at_eta = weather[:hourly].find { |forecast| (weather[:current][:dt] + response[:route][:time]) <= forecast[:dt] }
    RoadTrip.new(params, travel_time, weather_at_eta)
  end
end

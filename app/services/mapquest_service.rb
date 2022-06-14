class MapquestService < BaseService
  @geocoding_url = "http://mapquestapi.com/geocoding/v1/"
  @directions_url = "http://www.mapquestapi.com/directions/v2/"

  def self.get_location(city_state)
    get_json(conn(@geocoding_url, 'key', ENV['mapquest_key']).get("address?location=#{city_state}"))
  end

  def self.trip(params)
    get_json(conn(@directions_url, 'key', ENV['mapquest_key']).get("route?from=#{params[:origin]}&to=#{params[:destination]}"))
  end
end

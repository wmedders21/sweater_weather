class MapquestService < BaseService
  @url = "http://mapquestapi.com/geocoding/v1/"

  def self.get_location(city_state)
    get_json(conn(@url, 'key', ENV['mapquest_key']).get("address?location=#{city_state}"))
  end
end

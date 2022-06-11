class LocationFacade

  def self.get_location(city_state)
    response = MapquestService.get_location(city_state)
    location_coords = response[:results][0][:locations].first[:latLng]
    Location.new(location_coords)
  end
end

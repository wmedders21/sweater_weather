class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(locations, time, weather)
    @id = "null"
    @start_city = locations[:origin]
    @end_city = locations[:destination]
    @travel_time = "#{time[:hours]} hours, #{time[:minutes]} minutes"
    @weather_at_eta = {
      temperature: weather[:temp].round(1),
      conditions: weather[:weather].first[:description]
    }
  end
end

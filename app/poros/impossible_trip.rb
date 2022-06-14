class ImpossibleTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(params)
    @id = "null"
    @start_city = params[:origin]
    @end_city = params[:destination]
    @travel_time = "impossible"
    @weather_at_eta = {}
  end
end

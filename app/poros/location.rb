class Location
  attr_reader :lat, :lon
  def initialize(coords)
    @lat = coords[:lat]
    @lon = coords[:lng]
  end
end

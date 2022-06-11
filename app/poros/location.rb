class Location
  attr_reader :lat, :lng
  def initialize(coords)
    @lat = coords[:lat]
    @lng = coords[:lng]
  end
end

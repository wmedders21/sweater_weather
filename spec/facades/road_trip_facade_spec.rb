require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods' do
    it '#get_roadtrip returns a RoadTrip', :vcr do
      arg = {origin: "New York, NY", destination: "Los Angeles, CA"}
      expect(RoadTripFacade.get_roadtrip(arg)).to be_a(RoadTrip)
    end
  end
end

require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists' do
    trip = RoadTrip.new({origin: "Calhoun, GA", destination: "Rome, GA"}, {hours: 1, minutes: 15}, {temp: 88.88, weather: [{description: 'cloudy'}]})

    expect(trip).to be_a(RoadTrip)
    expect(trip.id).to eq("null")
    expect(trip.end_city).to eq("Rome, GA")
    expect(trip.start_city).to eq("Calhoun, GA")
    expect(trip.travel_time).to eq("1 hours, 15 minutes")
    expect(trip.weather_at_eta).to be_a(Hash)
    expect(trip.weather_at_eta[:temperature]).to eq(88.9)
    expect(trip.weather_at_eta[:conditions]).to eq("cloudy")
  end
end

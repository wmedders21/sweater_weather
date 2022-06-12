require 'rails_helper'

RSpec.describe Location do
  it 'exists' do
    coords = {:lat=>39.738453, :lng=>-104.984853}
    loc = Location.new(coords)

    expect(loc.lat).to eq(39.738453)
    expect(loc.lon).to eq(-104.984853)
    expect(loc).to be_a(Location)
  end
end

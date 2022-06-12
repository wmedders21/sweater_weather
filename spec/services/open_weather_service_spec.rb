require 'rails_helper'

RSpec.describe OpenWeatherService, :vcr do
  describe 'class methods' do
    it '#get_forecast' do
      location = Location.new({lat: 39.738453, lng: -104.984853})
      expect(OpenWeatherService.get_forecast(location)).to be_a(Hash)
    end
  end
end

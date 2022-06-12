require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods' do
    it 'get_forecast' do
      location = Location.new({lat: 39.738453, lng: -104.984853})
      json = JSON.parse(File.read("./spec/fixtures/open_weather_denver.json"), symbolize_names: true)
      allow(OpenWeatherService).to receive(:get_forecast).and_return(json)

      expect(WeatherFacade.get_forecast(location)).to be_a(Forecast)
    end
  end
end

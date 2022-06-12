require 'rails_helper'

RSpec.describe BackgroundFacade do
  describe 'class methods' do
    it '#get_background' do
      json = JSON.parse(File.read("./spec/fixtures/background.json"), symbolize_names: true)
      allow(BingImageService).to receive(:get_background).and_return(json)
      expect(BackgroundFacade.get_background('denver,co')).to be_a(Background)
    end
  end
end

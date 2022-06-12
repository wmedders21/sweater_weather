require 'rails_helper'

RSpec.describe ImagesFacade do
  describe 'class methods' do
    it '#get_background' do
      json = JSON.parse(File.read("./spec/fixtures/background.json"), symbolize_names: true)
      allow(BingImageService).to receive(:get_background).and_return(json)
      expect(ImagesFacade.get_background('denver,co')).to be_a(Image)
    end
  end
end

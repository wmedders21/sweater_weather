require 'rails_helper'

RSpec.describe LocationFacade do
  describe 'class methods' do
    it 'get_location' do
      json = JSON.parse(File.read("./spec/fixtures/mq_denver.json"), symbolize_names: true)
      allow(MapquestService).to receive(:get_location).and_return(json)

      expect(LocationFacade.get_location('denver,co')).to be_a(Location)
    end
  end
end

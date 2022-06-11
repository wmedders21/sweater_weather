require 'rails_helper'

RSpec.describe MapquestService do
  describe 'class methods' do
    it '#get_location' do
      city_state = 'denver,co'
      expect(MapquestService.get_location(city_state)).to be_a(Hash)
    end
  end
end

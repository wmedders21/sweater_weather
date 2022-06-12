require 'rails_helper'

RSpec.describe BingImageService, :vcr do
  describe 'class methods' do
    it '#get_background' do
      search_term = 'denver,co'
      expect(BingImageService.get_background(search_term)).to be_a(Hash)
    end
  end
end

require 'rails_helper'

RSpec.describe 'forecast endpoint' do
  before :each do
    get 'api/v1/forecast?location=denver,co'
    @response_body = JSON.parse(response.body, symbolize_names: true)
  end
  it 'returns data' do

    expect(@response_body).to have_key(:data)
    expect(@response_body[:data]).to be_a(Hash)
  end

  it 'data has id, type, and attributes' do

    data = response_body[:data]

    expect(data.count).to eq(3)

    expect(data).to have_key(:id)
    expect(data[:id]).to eq(nil)

    expect(data).to have_key(:type)
    expect(data[:id]).to eq("forecast")

    expect(data).to have_key(:attributes)
    expect(data[:id]).to be_a(Hash)
  end
end

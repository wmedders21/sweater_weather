require 'rails_helper'

Rspec.describe 'book-search endpoint' do
  before :each do
    get 'api/v1/book-search?location=denver,co&quantity=5'
    @response_body = JSON.parse(response.body, symbolize_names: true)
  end
  it 'returns data with id, type and attributes' do
    expect(response.status).to eq(200)
    expect(@response_body.keys).to eq([:data])
    expect(@response_body[:data]).to be_a(Hash)
    expect(@response_body[:data].keys).to eq([:id, :type, :attributes])
    expect(@response_body[:data][:type]).to eq("books")
    expect(@response_body[:data][:id]).to eq("null")
    expect(@response_body[:data][:attributes]).to be_a(Hash)
  end    
end

require 'rails_helper'

RSpec.describe 'road_trip endpoint' do
  describe 'happy path' do
    before :each do
      @user = User.create(email: "test@test.com", password: "password", api_key: SecureRandom.hex)
    end
    it 'returns data hash with type, id, and attributes', :vcr do

      body = { origin: "Denver, CO", destination: "Pueblo, CO", api_key: "#{@user.api_key}" }
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(response_body).to have_key(:data)
      expect(response_body[:data].keys).to eq([:id, :type, :attributes])
      expect(response_body[:data][:type]).to eq("roadtrip")
      expect(response_body[:data][:id]).to eq("null")
      expect(response_body[:data][:attributes]).to be_a(Hash)
      expect(response_body[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(response_body[:data][:attributes][:start_city]).to be_a(String)
      expect(response_body[:data][:attributes][:end_city]).to be_a(String)
      expect(response_body[:data][:attributes][:travel_time]).to be_a(String)
      expect(response_body[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(response_body[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      expect(response_body[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
      expect(response_body[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
  end

  describe 'edge cases/sad paths', :vcr do
    before :each do
      @user = User.create(email: "test@test.com", password: "password", api_key: SecureRandom.hex)
    end
    it 'edge case impossible trip', :vcr do

      body = { origin: "New York, NY", destination: "London, UK", api_key: "#{@user.api_key}" }
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(response_body).to have_key(:data)
      expect(response_body[:data].keys).to eq([:id, :type, :attributes])
      expect(response_body[:data][:type]).to eq("roadtrip")
      expect(response_body[:data][:id]).to eq("null")
      expect(response_body[:data][:attributes][:travel_time]).to eq('impossible')
      expect(response_body[:data][:attributes][:weather_at_eta]).to eq({})
    end
  end
end

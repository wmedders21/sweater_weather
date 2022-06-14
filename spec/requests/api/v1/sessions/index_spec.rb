require 'rails_helper'

RSpec.describe 'session endpoint' do
  describe 'happy path' do
    it 'returns data hash with type, id, and attributes' do
      body = { email: "test@test.com"}, password: "password"}
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/sessions', headers: headers, params: JSON.generate(body)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(response_body).to have_key(:data)
      expect(response_body[:data].keys).to eq([:id, :type, :attributes])
      expect(response_body[:data][:type]).to eq("users")
      expect(response_body[:data][:id]).to be_a(String)
      expect(response_body[:data][:attributes]).to be_a(Hash)
      expect(response_body[:data][:attributes].keys).to eq([:email, :api_key])
      expect(response_body[:data][:attributes][:email]).to be_a(String)
      expect(response_body[:data][:attributes][:api_key]).to be_a(String)
    end
  end
end

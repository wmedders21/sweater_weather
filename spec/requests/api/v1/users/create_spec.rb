require 'rails_helper'

RSpec.describe 'request to create a new user' do
  describe 'happy path' do
    it 'returns data hash with type, id, and attributes' do
      body = JSON.parse(File.read('./spec/fixtures/login_credentials.json'), symbolize_names: true)
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/users', headers: headers, params: JSON.generate(body)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
      expect(response_body).to have_key(:data)
      expect(response_body[:data].keys).to eq([:id, :type, :attributes])
      expect(response_body[:data][:type]).to eq("users")
      expect(response_body[:data][:id]).to be_a(String)
      expect(response_body[:data][:attributes]).to be_a(Hash)
      expect(response_body[:data][:attributes].keys).to eq([:email, :api_key])
      expect(response_body[:data][:attributes][:email]).to be_a(String)
      expect(response_body[:data][:attributes][:api_key]).to be_a(String)

      expect(User.find_by(email: 'whatever@example.com')).to be_a(User)
      expect(User.find_by(email: 'whatever@example.com').authenticate('password')).to be_a(User)
    end
  end

  describe 'sad paths' do
    it 'pw != pw confirmation returns an error message' do
      body = JSON.parse(File.read('./spec/fixtures/bad_credentials.json'), symbolize_names: true)
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/users', headers: headers, params: JSON.generate(body)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq('Password does not match password confirmation')
    end

    it 'email already exists returns an error message' do
      User.create(email: "whatever@example.com", password: "12345", password_confirmation: "12345")
      body = JSON.parse(File.read('./spec/fixtures/login_credentials.json'), symbolize_names: true)
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/users', headers: headers, params: JSON.generate(body)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq('Email entered is unavailable')
    end

    it 'empty field returns an error message' do
      body = { email: "", password: "password", password_confirmation: "password"}
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/users', headers: headers, params: JSON.generate(body)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq('Missing Field')
    end
  end
end

require 'rails_helper'

RSpec.describe 'request to create a new user' do
  it 'returns data hash with type, id, and attributes' do
    body = JSON.parse(File.read('./spec/fixtures/login_credentials.json'), symbolize_names: true)
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/users', headers: headers, params: JSON.generate(body)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(response_body).to have_key(:data)
    expect(response_body[:data].keys).to eq([:type, :id, :attributes])
    expect(response_body[:data][:type]).to eq("users")
    expect(response_body[:data][:id]).to be_a(Integer)
    expect(response_body[:data][:attributes]).to be_a(Hash)
    expect(response_body[:data][:attributes].keys).to eq([:email, :api_key])
    expect(response_body[:data][:attributes][:email]).to be_a(String)
    expect(response_body[:data][:attributes][:api_key]).to be_a(String)

    expect(User.find_by(email: 'whatever@example.com')).to be_a(User)
    expect(User.find_by(email: 'whatever@example.com').authenticate('password')).to be_a(User)
  end
end

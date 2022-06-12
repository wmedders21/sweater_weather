require 'rails_helper'

RSpec.describe 'backgrounds endpoint', :vcr do
  before :each do
    get '/api/v1/backgrounds?location=denver,co'
    @response_body = JSON.parse(response.body, symbolize_names: true)
  end

  it 'returns status 200', :vcr do
    expect(response.status).to eq(200)
  end

  it 'returns data', :vcr do
    expect(@response_body).to have_key(:data)
    expect(@response_body[:data]).to be_a(Hash)
  end

  it 'data has id, type, and attributes', :vcr do
    data = @response_body[:data]

    expect(data.count).to eq(3)

    expect(data).to have_key(:id)
    expect(data[:id]).to eq("null")

    expect(data).to have_key(:type)
    expect(data[:type]).to eq("image")

    expect(data).to have_key(:attributes)
    expect(data[:attributes]).to be_a(Hash)
  end

  it 'attributes', :vcr do
    attributes = @response_body[:data][:attributes]
    expect(attributes.keys).to eq([:image, :credit])
  end

  it 'image attribute', :vcr do
    image = @response_body[:data][:attributes][:image]
    expect(image.keys).to eq([:name, :image_url])
    expect(image[:name]).to be_a(String)
    expect(image[:image_url]).to be_a(String)
  end

  it 'credit attribute', :vcr do
    credit = @response_body[:data][:attributes][:credit]
    expect(credit.keys).to eq([:source, :author, :logo])
    expect(credit[:source]).to be_a(String)
    expect(credit[:author]).to be_a(String)
    expect(credit[:logo]).to be_a(String)
  end
end

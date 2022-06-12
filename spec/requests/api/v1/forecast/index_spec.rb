require 'rails_helper'

RSpec.describe 'forecast endpoint', :vcr do
  before :each do
    get '/api/v1/forecast?location=denver,co'
    @response_body = JSON.parse(response.body, symbolize_names: true)
  end

  it 'returns data' do
    expect(@response_body).to have_key(:data)
    expect(@response_body[:data]).to be_a(Hash)
  end

  it 'data has id, type, and attributes', :vcr do
    data = @response_body[:data]

    expect(data.count).to eq(3)

    expect(data).to have_key(:id)
    expect(data[:id]).to eq("null")

    expect(data).to have_key(:type)
    expect(data[:type]).to eq("forecast")

    expect(data).to have_key(:attributes)
    expect(data[:attributes]).to be_a(Hash)
  end

  it 'attributes', :vcr do
    attributes = @response_body[:data][:attributes]
    expect(attributes.keys).to eq([:current_weather, :daily_weather, :hourly_weather])
  end

  it 'current_weather', :vcr do
    current_weather = @response_body[:data][:attributes][:current_weather]
    expect(current_weather.keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
    expect(current_weather[:datetime]).to be_a(String)
    expect(current_weather[:sunrise]).to be_a(String)
    expect(current_weather[:sunset]).to be_a(String)
    expect(current_weather[:temperature]).to be_a(Numeric)
    expect(current_weather[:feels_like]).to be_a(Numeric)
    expect(current_weather[:humidity]).to be_a(Numeric)
    expect(current_weather[:uvi]).to be_a(Numeric)
    expect(current_weather[:visibility]).to be_a(Numeric)
    expect(current_weather[:conditions]).to be_a(String)
    expect(current_weather[:icon]).to be_a(String)
  end

  it 'daily_weather', :vcr do
    daily_weather = @response_body[:data][:attributes][:daily_weather]
    daily_weather.each do |day|
      expect(day.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      expect(day[:date]).to be_a(String)
      expect(day[:sunrise]).to be_a(String)
      expect(day[:sunset]).to be_a(String)
      expect(day[:max_temp]).to be_a(Numeric)
      expect(day[:min_temp]).to be_a(Numeric)
      expect(day[:conditions]).to be_a(String)
      expect(day[:icon]).to be_a(String)
    end
  end

  it 'hourly_weather', :vcr do
    hourly_weather = @response_body[:data][:attributes][:hourly_weather]
    hourly_weather.each do |hour|
      expect(hour.keys).to eq([:time, :temperature, :conditions, :icon])
      expect(hour[:time]).to be_a(String)
      expect(hour[:temperature]).to be_a(Numeric)
      expect(hour[:conditions]).to be_a(String)
      expect(hour[:icon]).to be_a(String)
    end
  end
end

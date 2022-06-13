require 'rails_helper'

RSpec.describe 'book-search endpoint' do
  before :each do
    get '/api/v1/book-search?location=denver,co&quantity=5'
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

  it 'contains attributes destination, forecast, total_books_found, and books' do
    attributes = @response_body[:data][:attributes]

    expect(attributes.keys.count).to eq(4)
    expect(attributes.keys).to eq([:destination, :forecast, :total_books_found, :books])
    expect(attributes[:destination]).to be_a(String)
    expect(attributes[:forecast]).to be_a(Hash)
    expect(attributes[:forecast].keys).to eq([:summary, :temperature])
    expect(attributes[:forecast][:summary]).to be_a(String)
    expect(attributes[:forecast][:temperature]).to be_a(String)
    expect(attributes[:total_books_found]).to be_a(Integer)
    expect(attributes[:books]).to be_a(Array)
    expect(attributes[:books].count).to eq(5)
  end

  it 'returns a list of books' do
    books = @response_body[:data][:attributes][:books]

    books.each do |book|
      expect(book.keys).to eq([:isbn, :title, :publisher])
      expect(book[:isbn]).to be_a(Array)
      expect(book[:title]).to be_a(String)
      expect(book[:publisher]).to be_a(Array)
    end
  end
end

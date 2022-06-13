require 'rails_helper'

RSpec.describe BookSearch do
  it 'exists' do
    location = 'denver,co'
    weather = {:conditions=>"clear sky", :temperature=>"89 F"}
    library = JSON.parse(File.read("./spec/fixtures/library.json"), symbolize_names: true)

    bs = BookSearch.new(location, weather, library)

    expect(bs.id).to eq("null")
    expect(bs.destination).to eq("denver,co")
    expect(bs.forecast).to eq({ :summary=>"clear sky", :temperature=>"89 F" })
    expect(bs.total_books_found).to eq(55)
    expect(bs.books).to be_a(Array)
  end
end

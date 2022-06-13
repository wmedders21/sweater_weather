class BookSearchFacade

  def self.search_books(params)
    coords = LocationFacade.get_location(params[:location])
    forecast = WeatherFacade.get_forecast(coords)
    forecast_data = { conditions: forecast.current_weather.conditions, temperature: (forecast.current_weather.temperature.to_i.to_s + " F") }
    location = params[:location].split(",")[0]
    library_search = OpenLibraryService.search_books(location, params[:quantity])
    BookSearch.new(library_search, forecast_data)
  end
end

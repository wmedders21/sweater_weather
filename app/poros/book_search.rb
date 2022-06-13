class BookSearch
  attr_reader :id, :destination, :forecast, :total_books_found, :books

  def initialize(location, weather, library)
    @id = "null"
    @destination = location
    @forecast = { summary: weather[:conditions], temperature: weather[:temperature] }
    @total_books_found = library[:numFound]
    @books = library[:docs].map do |book|
      { isbn: book[:isbn], title: book[:title], publisher: book[:publisher] }
    end
  end
end

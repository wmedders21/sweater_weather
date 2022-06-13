class OpenLibraryService < BaseService
  @url = "http://openlibrary.org/search.json"

  def self.conn(url)
    Faraday.new(url: url)
  end

  def self.search_books(keyword, limit)
    get_json(conn(@url).get("?q=subject:travel place:#{keyword}&limit=#{limit}"))
  end
end

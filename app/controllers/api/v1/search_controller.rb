class Api::V1::SearchController < ApplicationController

  def books
    book_search = BookSearchFacade.search_books(search_params)
    render json: BookSearchSerializer.new(book_search)
  end

  private

  def search_params
    params.permit(:location, :quantity)
  end
end

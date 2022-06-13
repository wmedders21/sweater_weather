class Api::V1::SearchController < ApplicationController
  before_action :check_quantity

  def books
    book_search = BookSearchFacade.search_books(search_params)
    render json: BookSearchSerializer.new(book_search)
  end

  private

  def search_params
    params.permit(:location, :quantity)
  end

  def check_quantity
    if params[:quantity].to_i < 1
      render json: { error: "Quantity can't be less than 1"}, status:400
    end
  end
end

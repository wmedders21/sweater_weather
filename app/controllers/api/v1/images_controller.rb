class Api::V1::ImagesController < ApplicationController

  def background
    background = ImagesFacade.get_background(params[:location])
    render json:  ImageSerializer.new(background)
  end
end

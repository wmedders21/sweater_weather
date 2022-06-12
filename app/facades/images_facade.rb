class ImagesFacade

  def self.get_background(search_term)
    data = BingImageService.get_background(search_term)[:value].first
    Image.new(data)
  end
end

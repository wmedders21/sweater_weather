class BackgroundFacade

  def self.get_background(search_term)
    data = BingImageService.get_background(search_term)[:value].first
    Background.new(data)
  end
end

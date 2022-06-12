class Background
  attr_reader :image, :credit
  def initialize(data)
    @image = {
      name: data[:name],
      image_url: data[:contentUrl]
    }

    @credit = {
      source: data[:hostPageUrl],
      author: data[:hostPageDomainFriendlyName],
      logo: data[:hostPageFavIconUrl]
    }
  end
end

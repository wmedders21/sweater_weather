class Background
  attr_reader :id, :type, :attributes
  def initialize(data)
    @id = 'null'
    @type = 'image'
    @attributes = {
      image: {
        name: data[:name],
        image_url: data[:contentUrl]
      },
      credit: {
        source: data[:hostPageUrl],
        author: data[:hostPageDomainFriendlyName],
        logo: data[:hostPageFavIconUrl]
      }
    }
  end
end

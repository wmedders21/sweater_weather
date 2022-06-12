class Image
  attr_reader :id, :type, :image
  def initialize(data)
    @id = 'null'
    @type = 'image'
    @image = {
        name: data[:name],
        image_url: data[:contentUrl],
        credit: {
          source: data[:hostPageUrl],
          author: data[:hostPageDomainFriendlyName],
          logo: data[:hostPageFavIconUrl]
      }
    }
  end
end

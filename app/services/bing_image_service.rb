class BingImageService < BaseService
  @url = "https://api.bing.microsoft.com/v7.0/images/search"

  def self.conn(url, keyname, key)
    Faraday.new(url: url) do |faraday|
      faraday.headers[keyname] = key
    end
  end

  def self.get_background(search_term)
    get_json(conn(@url, 'Ocp-Apim-Subscription-Key', ENV['bing_images_key'])
    .get("?q=#{search_term}&count=1&mkt=en-us&safeSearch=Strict"))
  end
end

class BaseService

  def self.conn(url, keyname, key)
    Faraday.new(url: url) do |faraday|
      faraday.params[keyname] = key
    end
  end

  def self.get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

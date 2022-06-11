class BaseService

  def self.conn(url, key)
    Faraday.new(url: url) do |faraday|
      faraday.params['key'] = key
    end
  end

  def self.get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

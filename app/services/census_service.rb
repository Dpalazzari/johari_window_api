class CensusService
  def self.get_token
    new.get_token
  end

  def get_token
    res = conn.post do |req|
      req.url '/oauth/token'
      req.params['grant_type'] = 'client_credentials'
      req.params['client_id'] = ENV['CENSUS_CLIENT_ID']
      req.params['client_secret'] = ENV['CENSUS_SECRET_ID']
    end
    JSON.parse(res.body)['access_token']
  end

  def conn
    Faraday.new(url: 'https://turing-census.herokuapp.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
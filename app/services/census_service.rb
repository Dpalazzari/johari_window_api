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

  def self.get_data_by_github(username)
    new.get_data_by_github(username)
  end

  def get_data_by_github(username)
    res = get_data(username)
    cohort = res['cohort']['name'] rescue nil
    roles = res['roles'].map { |role| role['name'] } rescue nil
    { cohort: cohort, roles: roles }
  end

  def get_data(username)
    res = conn.get do |req|
      req.url '/api/v1/users/by_github'
      req.params['q'] = username
      req.params['access_token'] = ENV['CENSUS_TOKEN']
    end
    JSON.parse(res.body)
  end

end

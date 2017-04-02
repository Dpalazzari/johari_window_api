class Johari
  # attr_reader :user, :self_described, :peer_described
  attr_reader :user

  def initialize(user)
    @user = user
    # @self_described = Description.find_adjectives(user.descriptions.where("describer_id = ?", user.id)) 
    # @peer_described = Description.find_adjectives(user.descriptions.where.not("describer_id = ?", user.id)) 
  end

  def self_described
    descriptions = user.descriptions.where('describer_id = ?', user.id)
    descriptions.all.map {|description| description.adjective }
  end

  def peer_described
    descriptions = user.descriptions.where.not('describer_id = ?', user.id)
    descriptions.all.map {|description| description.adjective }
  end

  def format_descriptions
    johari = Hash.new(0)
    johari["arena"] = arena_window
    johari["facade"] = facade_window
    johari["blind-spot"] = blind_spot_window
    johari["unknown"] = unknown_window
    johari
  end

  def window(adjectives)
    adjectives.uniq.map do |adj| 
      {'name': adj.name, 'frequency': 1}
    end
  end

  def window_with_freq(adjectives)
    total = peer_described.count.to_f / 10
    counts = get_counts(adjectives)
    counts.map do |adj, count|
      {'name': adj, 'frequency': (count.to_f / total) }
    end
  end

  def get_counts(adjectives)
    counts = adjectives.reduce(Hash.new(0)) do |freq, adj|
      freq[adj.name] += 1
      freq
    end
  end

  def arena_adjectives
    peer_described.find_all do |adjective|
      self_described.include?(adjective)
    end
  end
 
  def facade_adjectives
    self_described.find_all do |adjective|
      !peer_described.include?(adjective)
    end
  end
  
  def blind_spot_adjectives
    peer_described.find_all do |adjective|
      !self_described.include?(adjective)
    end
  end
  
  def unknown_adjectives
    Adjective.all.find_all do |adj|
      !user.adjectives.include?(adj)
    end
  end

  def arena_window
    window_with_freq(arena_adjectives)
  end

  def facade_window
    window(facade_adjectives)
  end

  def blind_spot_window
    window_with_freq(blind_spot_adjectives)
  end

  def unknown_window
    window(unknown_adjectives)
  end
end

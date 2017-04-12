class Johari

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def adj_per_johari
    15
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
    adjectives.uniq.map { |adj| {'name': adj.name, 'frequency': 1} }
  end

  def window_with_freq(adjectives)
    total = peer_described.count.to_f / adj_per_johari
    counts = get_counts(adjectives)
    counts.map do |adj, count|
      {'name': adj, 'frequency': (count.to_f / total) }
    end
  end

  def get_counts(adjectives)
    adjectives.reduce(Hash.new(0)) do |freq, adj|
      freq[adj.name] += 1
      freq
    end.sort_by { |adj, count| count }.reverse.to_h
  end

  def arena_adjectives
    peer_described.find_all { |adj| self_described.include?(adj) }
  end
 
  def facade_adjectives
    self_described.find_all { |adj| !peer_described.include?(adj) }
  end
  
  def blind_spot_adjectives
    peer_described.find_all { |adj| !self_described.include?(adj) }
  end
  
  def unknown_adjectives
    Adjective.all.find_all { |adj| !user.adjectives.include?(adj) }
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

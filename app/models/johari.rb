class Johari
  attr_reader :user, :self_described, :peer_described

  def initialize(user)
    @user = user
    @self_described = Description.find_adjectives(user.descriptions.where("describer_id = ?", user.id)) 
    @peer_described = Description.find_adjectives(user.descriptions.where.not("describer_id = ?", user.id)) 
  end

  def format_descriptions
    johari = Hash.new(0)
    johari["arena"] = arena
    johari["facade"] = facade
    johari["blind-spot"] = blind_spot
    johari["unknown"] = unknown
    johari
  end

  def arena
    adjectives = self_described.find_all do |adjective|
      peer_described.include?(adjective)
    end.compact
    create_window(adjectives)
  end
 
  def facade
    adjectives = self_described.find_all do |adjective|
      !peer_described.include?(adjective)
    end.compact
    create_window(adjectives)
  end
  
  def blind_spot
    adjectives = peer_described.find_all do |adjective|
      !self_described.include?(adjective)
    end.compact
    create_window(adjectives)
  end
  
  def unknown
    unknown = Adjective.all.find_all do |adj|
      !user.adjectives.include?(adj)
    end.compact
    create_window(unknown)
  end
  
  def create_window(adjectives)
    adjectives.map do |adj|
      {"name": adj.name, "frequency": get_frequency(adj) }
    end
  end

  def get_frequency(adjective)
    user.descriptions.where("adjective_id = ?", adjective.id).count.to_f / user.descriptions.count
  end
end

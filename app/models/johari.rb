class Johari
  attr_reader :user, :self_described, :peer_described, :johari

  def initialize(user)
    @user = user
    @self_described = Description.find_adjectives(user.descriptions.where("describer_id = ?", user.id)) 
    @peer_described = Description.find_adjectives(user.descriptions.where.not("describer_id = ?", user.id)) 
    @johari = Hash.new(0)
  end

  def format_descriptions
    @johari["arena"] = self.arena(self_described, peer_described)
    @johari["facade"] = self.facade(self_described, peer_described)
    @johari["blind-spot"] = self.blind_spot(self_described, peer_described)
    @johari["unknown"] = self.unknown
    johari
  end

  def arena(self_described, peer_described)
    adjectives = self_described.map do |adjective|
      adjective if peer_described.include?(adjective)
    end.compact
    create_window(adjectives)
  end
 
  def facade(self_described, peer_described)
    adjectives = self_described.map do |adjective|
      adjective if !peer_described.include?(adjective)
    end.compact
    create_window(adjectives)
  end
  
  def blind_spot(self_described, peer_described)
    adjectives = peer_described.map do |adjective|
      adjective if !self_described.include?(adjective)
    end.compact
    create_window(adjectives)
  end
  
  def unknown
    unknown = Adjective.all.map do |adj|
      adj if !user.adjectives.include?(adj)
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

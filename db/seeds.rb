class Seed

  def self.start
    seed = Seed.new
    seed.generate_adjectives
  end

  def generate_adjectives
    adjectives = %w(able accepting adaptable bold brave calm caring 
    cheerful clever complex confident dependable dignified empathetic 
    energetic extroverted friendly giving happy helpful idealistic 
    independent ingenious intelligent introverted kind knowledgeable 
    logical loving mature modest nervous observant organized patient 
    powerful proud quiet reflective relaxed religious responsive 
    searching self-assertive self-conscious sensible sentimental 
    shy silly spontaneous sympathetic tense trustworthy warm wise witty)
    
    adjectives.each { |adj| Adjective.create!(name: adj)}
  end

end

Seed.start
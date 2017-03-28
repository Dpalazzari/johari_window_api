class Seed

  def self.start
    clear_database
    seed = Seed.new
    seed.generate_adjectives
    seed.generate_users
    seed.generate_assignments
  end

  def self.clear_database
    Assignment.delete_all
    User.delete_all
    Adjective.delete_all
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

  def generate_users
    150.times do 
      User.create!(name: Faker::GameOfThrones.character)
    end
  end

  def generate_assignments
    User.all.each do |user|
      4.times do
        user.assignments.create!(assigned: User.all.sample)
      end
      user.assignments.create!(assigned: User.all.sample, completed?: true)
    end
    
  end

end

Seed.start
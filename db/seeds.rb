class Seed

  def self.start
    clear_database
    seed = Seed.new
    seed.generate_adjectives
    seed.generate_cohorts
    seed.generate_users
    seed.generate_assignments
  end

  def self.clear_database
    Assignment.delete_all
    User.delete_all
    Cohort.delete_all
    Adjective.delete_all
  end

  def generate_adjectives
    adjectives = %w(able accepting accountable adaptable aggressive 
    assertive available bold brave calm caring cheerful clever collaborative
    communicative competitive complex confident dependable dignified discouraged 
    disingenuous disorganized distracted driven egotistical empathetic energetic 
    extroverted focused friendly giving happy hardworking helpful helpless honest 
    idealistic impatient independent ingenious intelligent introverted irresponsible 
    kind knowledgeable logical mature modest motivating needy nervous oblivious 
    observant organized passive patient perserverant positive powerful proud reflective 
    relaxed relentless responsible responsive rigid rude searching self-conscious selfish 
    selfless sensible sentimental spontaneous strategic sympathetic tense trustworthy 
    unavailable uncaring uncompromising unfocused unresponsive warm witty wise withholding)
    
    adjectives.each { |adj| Adjective.create!(name: adj)}
  end

  def generate_cohorts
    Cohort.create!(name: '1610BE')
    Cohort.create!(name: '1610FE')
    Cohort.create!(name: '1611BE')
    Cohort.create!(name: '1611FE')
  end

  def generate_users
    150.times do 
      github_name = 'github' + rand(100000).to_s
      User.create!(name: Faker::GameOfThrones.character, github: github_name, token: SecureRandom.hex, cohort: Cohort.all.sample)
    end
  end

  def generate_assignments
    User.all.each do |user|
      4.times do
        user.assignments.create!(assigned: User.all.sample)
      end
      described = User.all.sample
      user.assignments.create!(assigned: described, completed?: true)
      10.times do
        described.descriptions.create!(describer: user, adjective: Adjective.all.sample)
      end
    end 
  end
    
end

Seed.start
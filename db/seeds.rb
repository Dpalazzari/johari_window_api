class Seed

  def self.start
    clear_database
    seed = Seed.new
    seed.generate_adjectives
    seed.generate_cohorts
    seed.generate_users
  end

  def self.clear_database
    Description.delete_all
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
    Cohort.create!(name: '1610-BE')
    Cohort.create!(name: '1610-FE')
    Cohort.create!(name: '1611-BE')
    Cohort.create!(name: '1611-FE')
  end

  def generate_users
    students = ['Annie Wolff',
                'Caroline Powell',
                'Daniel Rodriguez',
                'Drew Palazzari',
                'Jason Conrad',
                'Jesse Shipley',
                'Pudding',
                'Laszlo Balogh',
                'Lucy Conklin',
                'Amy Kintner',
                'David Knott',
                'Kyle Heppenstall',
                'Mike Schutte',
                'Molly Brown',
                'Nick Erhardt',
                'Nick Gheorghita',
                'Robbie Smith',
                'Casey Cumbow']
    cohort = Cohort.find_by(name: "1610-BE")
    students.each do |student|
      github_name = 'github' + rand(100000).to_s
      User.create!(name: student, github: github_name, token: SecureRandom.hex, cohort: cohort)
    end
  end
end

Seed.start

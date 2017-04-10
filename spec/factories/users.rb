FactoryGirl.define do
  factory :user do
    name { Faker::GameOfThrones.character }
    token { SecureRandom.hex }
    github { 'github' + rand(1000000).to_s }
  end
end

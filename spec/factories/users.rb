FactoryGirl.define do
  factory :user do
    name { Faker::GameOfThrones.character + rand(100).to_s }
    cohort
  end
end

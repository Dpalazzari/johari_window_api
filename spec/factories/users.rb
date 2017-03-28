FactoryGirl.define do
  factory :user do
    name Faker::GameOfThrones.character
  end
end

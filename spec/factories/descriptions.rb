FactoryGirl.define do
  factory :description do
    association :describee, factory: :user
    association :describer, factory: :user
    association :adjective, factory: :adjective
  end
end

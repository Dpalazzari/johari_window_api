FactoryGirl.define do
  factory :assignment do
    association :assignee, factory: :user
    association :assigned, factory: :user
  end
end

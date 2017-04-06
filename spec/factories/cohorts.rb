FactoryGirl.define do
  factory :cohort do
    name { rand(1000).to_s + ['backend', 'frontend'].sample }
  end
end

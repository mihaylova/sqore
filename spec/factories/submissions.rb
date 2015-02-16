FactoryGirl.define do
  factory :submission do
    association :competition, factory: :competition
  end
end

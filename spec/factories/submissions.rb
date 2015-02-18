FactoryGirl.define do
  factory :submission do
    submitted_at Time.now
    association :competition, factory: :competition
    association :user, factory: :user
    finished true
    checked true
  end
end

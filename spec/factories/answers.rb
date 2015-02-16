FactoryGirl.define do
  factory :answer do
    text 'answer'
    association :submission, factory: :submission
  end
end

FactoryGirl.define do
  factory :answer do
    text 'answer'
    association :submission, factory: :submission
    association :question, factory: :question
  end
end

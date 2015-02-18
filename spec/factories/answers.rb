FactoryGirl.define do
  factory :answer do
    text 'answer'
    association :question, factory: :question
  end
end

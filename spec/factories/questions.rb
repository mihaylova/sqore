FactoryGirl.define do
  factory :question do
    text 'Question?'
    association :question_set, factory: :question_set
  end
end

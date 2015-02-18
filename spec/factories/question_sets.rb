FactoryGirl.define do
  factory :question_set do
    association :competition, factory: :competition
    sequence :tag do |n|
      "tag_#{n}"
    end
  end
end

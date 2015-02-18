FactoryGirl.define do
  factory :question_set do
    sequence :tag do |n|
      "tag_#{n}"
    end
  end
end

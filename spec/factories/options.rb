FactoryGirl.define do
  factory :option do
    sequence :text do |n|
      "option#{n}"
    end
    score 1
  end
end

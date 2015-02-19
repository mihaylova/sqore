FactoryGirl.define do
  factory :fb_post do
    sequence :fb_id do |n|
      "111111#{n}"
    end
  end

end

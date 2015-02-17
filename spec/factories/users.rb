FactoryGirl.define do
  factory :user do
    name 'Inna Mihaylova'
    sequence :email do |n|
      "email#{n}@mail.com"
    end
  end
end

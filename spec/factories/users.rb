FactoryGirl.define do
  factory :user do
    name 'Inna Mihaylova'
    sequence :email do |n|
      "email#{n}@mail.com"
    end
    factory :user_with_files do
    after(:create) do |user|
      create_list(:user_cloud_storage_file, 2, user: user)
    end
  end
  end
end

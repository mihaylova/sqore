FactoryGirl.define do
  factory :user_cloud_storage_file do
    sequence :url do |n|
      "http://www.cloud/files/#{n}.com"
    end
  end

end

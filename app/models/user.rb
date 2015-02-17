class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :uid, type: Integer

  embeds_many :user_cloud_storage_files
end

class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :uid, type: Integer

  validates_presence_of :name, :email

  embeds_many :user_cloud_storage_files
  has_many :submissions
end

class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :uid, type: Integer
  field :access_token, type: String

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  embeds_many :files,
              class_name: 'UserCloudStorageFile',
              store_as: 'user_cloud_storage_files'

  has_many :submissions, dependent: :destroy
end

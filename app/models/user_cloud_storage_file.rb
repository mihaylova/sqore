class UserCloudStorageFile
  include Mongoid::Document
  field :url, type: String

  validates_presence_of :url

  embedded_in :user
end

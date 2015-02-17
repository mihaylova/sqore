class UserCloudStorageFile
  include Mongoid::Document
  field :url, type: String

  embedded_in :user
end

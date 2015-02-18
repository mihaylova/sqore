class QuestionSet
  include Mongoid::Document
  field :tag, type: String

  has_many :questions
  embedded_in :competition

  validates_presence_of :tag
  validates_uniqueness_of :tag
end

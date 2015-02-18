class QuestionSet
  include Mongoid::Document

  field :tag, type: String
  field :_id, type: String, default: -> { tag }

  has_many :questions
  embedded_in :competitions

  validates_presence_of :tag
end

class QuestionSet
  include Mongoid::Document

  field :tag, type: String
  field :_id, type: String, default: -> { tag }

  has_many :questions
  has_and_belongs_to_many :competitions
end

class Question
  include Mongoid::Document

  field :text, type: String
  field :tag, type: String

  validates_presence_of :text, :tag

  belongs_to :question_set, foreign_key: 'tag'
  has_many :options
  has_many :answers
end

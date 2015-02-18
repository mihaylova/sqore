class Question
  include Mongoid::Document

  field :text, type: String

  validates_presence_of :text
  validates_associated :question_set

  belongs_to :question_set
  embeds_many :options
  has_many :answers, dependent: :destroy
end

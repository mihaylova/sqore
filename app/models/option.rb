class Option
  include Mongoid::Document

  field :text, type: String
  field :score, type: Integer
  field :question_id, type: Integer

  belongs_to :question
end

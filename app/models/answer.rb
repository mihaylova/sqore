class Answer
  include Mongoid::Document

  field :given_answer, type: String
  field :score, type: Integer
  filed :skipped, type: Boolean
  field :question_id, type: Integer
  field :sumbission_id, type: Integer

  belongs_to :sumbission
  belongs_to :question
end

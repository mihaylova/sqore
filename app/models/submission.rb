class Submission
  include Mongoid::Document

  field :total, type: Integer
  field :user_id, type: Integer
  field :competition_id, type: Integer
  filed :submitted_at, type: DateTime

  belongs_to :user
  belongs_to :competition
  has_many :answers
end

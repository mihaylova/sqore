class Submission
  include Mongoid::Document

  field :total, type: Integer
  field :user_id, type: Integer
  field :competition_id, type: Integer
  field :submitted_at, type: DateTime
  field :checked, type: Boolean

  belongs_to :user
  belongs_to :competition
  has_many :answers

  def update_total
    scores = answers.map(&:score)
    if scores.select(&:nil?).any?
      update(checked: false)
    else
      update(total: scores.sum, checked: true)
    end
  end
end

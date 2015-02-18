class Submission
  include Mongoid::Document

  field :total, type: Integer
  field :user_id, type: Integer
  field :submitted_at, type: DateTime
  field :checked, type: Boolean, default: false
  field :finished, type: Boolean, default: false

  belongs_to :user
  belongs_to :competition
  has_many :answers,
           dependent: :destroy,
           before_add: :validate_answer,
           after_add: :finish_submission?

  validates_presence_of :user_id, :submitted_at
  validates_associated :competition, :user

  default_scope -> { where(checked: true).where(finished: true) }
  scope :unchecked, -> { where(checked: false) }
  scope :unfinished, -> { where(finished: false) }

  def update_total
    scores = answers.map(&:score)
    if scores.any?(&:nil?)
      update(checked: false)
    else
      update(total: scores.sum, checked: true)
    end
  end

  private

  def finish_submission?(_answer)
    update(finished: true) if answers.map(&:question_id) == competition.question_ids
  end

  def validate_answer(answer)
    fail Exception('Invalid Answer!') unless valid_answer?(answer)
  end

  def valid_answer?(answer)
    competition.question_ids.include? answer.question_id
  end
end

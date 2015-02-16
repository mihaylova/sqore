class Answer
  include Mongoid::Document

  field :text, type: String
  field :score, type: Integer
  field :skipped, type: Boolean, default: false
  field :question_id, type: Integer
  field :submission_id, type: Integer

  belongs_to :submission
  belongs_to :question

  validates_presence_of :text, :question_id, :submission_id

  # Are we actually going to destroy answers?
  # before_destroy :update_submission_total

  after_save :update_submission_total
  after_create :calculate_score

  def update_submission_total
    submission.update_total
  end

  def calculate_score
    update(score: question.options.where(text: text).first.score) if question.options?
  end
end

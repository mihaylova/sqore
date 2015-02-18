class Answer
  include Mongoid::Document

  field :text, type: String
  field :score, type: Integer
  field :option_id
  field :skipped, type: Boolean, default: false
  field :question_id, type: Integer
  field :submission_id, type: Integer

  belongs_to :submission
  belongs_to :question

  validates_presence_of :text
  validates_associated :question, :submission
  validate :question_option, if: :quiz_question?

  # Are we actually going to destroy answers?
  # before_destroy :update_submission_total

  after_save :update_submission_total
  after_create :set_score

  private

  def update_submission_total
    submission.update_total
  end

  def calculate_score
    return 0 if skipped
    question.options.where(text: text).where(id: option_id).first.score if quiz_question?
  end

  def set_score
    update(score: calculate_score)
  end

  def quiz_question?
    question.options?
  end

  def question_option
    return true if question.options.map(&:id).include? option_id
    errors[:base] << 'The option ID is not correct'
    false
  end
end

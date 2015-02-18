class Submission
  include Mongoid::Document

  field :total, type: Integer
  field :user_id, type: Integer
  field :competition_id, type: Integer
  field :submitted_at, type: DateTime
  field :checked, type: Boolean

  belongs_to :user
  belongs_to :competition
  has_many :answers, dependent: :destroy

  validates_presence_of :user_id, :submitted_at
  validates_associated :competition, :user

  default_scope -> { where(checked: true) }
  scope :unchecked, -> { where(checked: false) }

  def update_total
    scores = answers.map(&:score)
    if scores.any?(&:nil?)
      update(checked: false)
    else
      update(total: scores.sum, checked: true)
    end
  end
end

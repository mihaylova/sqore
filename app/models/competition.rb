class Competition
  include Mongoid::Document

  embeds_many :question_sets
  has_many :submissions, dependent: :destroy

  def generate_report
    submissions.includes(:user).map do |submission|
      { name: submission.user.name,
        email: submission.user.email,
        total: submission.total,
        user_files: submission.user.files.map(&:url).join(', ') }
    end
  end
end

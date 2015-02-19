class Competition
  include Mongoid::Document

  embeds_many :question_sets
  has_many :submissions, dependent: :destroy
  has_many :fb_posts, dependent: :destroy

  def question_ids
    question_sets.map(&:question_ids).flatten.sort
  end

  def generate_report
    graph = Koala::Facebook::API.new
    submissions.includes(:user).map do |submission|
      fb_post = fb_posts.where(user: submission.user).first
      fb_data = fb_post.try(:data, graph) || FbPost.no_data
      { name: submission.user.name,
        email: submission.user.email,
        total: submission.total,
        user_files: submission.user.files.map(&:url).join(', '),
        fb_shares: fb_data[:shares],
        fb_comments: fb_data[:comments] }
    end
  end
end

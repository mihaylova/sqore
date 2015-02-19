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
      submission.generate_report_data.merge(fb_data)
    end
  end
end

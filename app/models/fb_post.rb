class FbPost
  include Mongoid::Document
  field :fb_id, type: Integer

  belongs_to :user
  belongs_to :competition

  validates_presence_of :fb_id
  validates_uniqueness_of :fb_id

  def data(graph)
    fb_object = get_fb_object(graph)

    if fb_object
      shares = fb_object['shares']['data'].try(:size) || 0
      comments = fb_object['comments']['data'].try(:size) || 0
    else
      comments = 'no data'
      shares = 'no data'
    end
    { shares: shares, comments: comments }
  end

  def self.no_data
    { shares: 'no data', comments: 'no data' }
  end

  private

  def get_fb_object(graph)
    graph.get_object(fb_id)
    rescue Exception
      nil
  end
end

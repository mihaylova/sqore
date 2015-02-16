class Competition
  include Mongoid::Document

  has_and_belongs_to_many :question_sets
end

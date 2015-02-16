class Option
  include Mongoid::Document

  field :text, type: String
  field :score, type: Integer

  embedded_in :question

  validates_presence_of :text, :score
end

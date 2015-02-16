class Option
  include Mongoid::Document

  field :text, type: String
  field :score, type: Integer

  embedded_in :question
end

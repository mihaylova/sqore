require 'rails_helper'

RSpec.describe Submission, :type => :model do
  describe 'scopes' do
    let!(:checked_submission) { create(:submission, checked: true) }
    let!(:unchecked_submission) { create(:submission, checked: false) }

    describe 'default_scope' do
      it { expect(Submission.all).to eq [checked_submission] }
    end

    describe '.unchecked' do
      it { expect(Submission.unchecked).to eq [unchecked_submission] }
    end
  end

  describe 'answers' do
    context 'before add' do
      let!(:question) { create(:question) }
      let!(:submission) { create(:submission, competition: question.question_set.competition) }
      let!(:valid_answer) { build(:answer, question: question) }
      let!(:invalid_answer) { build(:answer, question_id: 0) }

      it { expect { submission.answers << invalid_answer }.to raise_error }
      it { expect { submission.answers << valid_answer }.to change { submission.answers.size }.by(1) }
    end
  end
end

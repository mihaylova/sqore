require 'rails_helper'

RSpec.describe Submission, :type => :model do
  describe 'scopes' do
    let!(:checked_submission) { create(:submission, checked: true) }
    let!(:unchecked_submission) { create(:submission, checked: false) }
    let!(:finished_submission) { create(:submission, finished: true) }
    let!(:unfinished_submission) { create(:submission, finished: false) }

    describe 'default_scope' do
      it { expect(Submission.all).to eq [checked_submission, finished_submission] }
    end

    describe '.unchecked' do
      it { expect(Submission.unchecked).to eq [unchecked_submission] }
    end

    describe '.unfinished' do
      it { expect(Submission.unfinished).to eq [unfinished_submission] }
    end
  end

  describe 'answers' do
    context 'before add' do
      let(:question) { create(:question) }
      let(:submission) { create(:submission, competition: question.question_set.competition) }
      let!(:valid_answer) { build(:answer, question: question) }
      let!(:invalid_answer) { build(:answer, question_id: 0) }

      it { expect { submission.answers << invalid_answer }.to raise_error }
      it { expect { submission.answers << valid_answer }.to change { submission.answers.size }.by(1) }
    end

    context 'after add' do
      let(:question_set) { create(:question_set) }
      let(:submission) { create(:submission, competition: question_set.competition, finished: false) }
      let!(:question1) { create(:question, question_set: question_set) }
      let!(:question2) { create(:question, question_set: question_set) }

      context 'if all questions have answers' do
        before do
          create(:answer, submission: submission, question: question1)
          create(:answer, submission: submission, question: question2)
        end

        it { expect(submission.finished).to be true }
      end

      context 'if some questions do not have answers' do
        before do
          create(:answer, submission: submission, question: question1)
        end

        it { expect(submission.finished).to be false }
      end
    end
  end
end

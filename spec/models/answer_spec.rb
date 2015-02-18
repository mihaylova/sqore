require 'rails_helper'

RSpec.describe Answer, :type => :model do
  describe '#set_score' do
    let!(:question) { create(:question) }
    # in order to have valid answers
    let!(:submission) { create(:submission, competition: question.question_set.competition) }

    describe 'on Quiz question' do
      let!(:correct) { create(:option, score: 1, question: question) }
      let!(:incorrect) { create(:option, score: 0, question: question) }

      context 'when the answer is correct' do
        let(:answer) { create(:answer, text: correct.text, question: question, submission: submission) }
        it { expect(answer.score).to be 1 }
      end

      context 'when the answer is incorrect' do
        let!(:answer) { create(:answer, text: incorrect.text, question: question, submission: submission) }
        it { expect(answer.score).to be 0 }
      end
    end

    describe 'on Open question' do
      let!(:answer) { create(:answer, question: question, submission: submission) }
      it { expect(answer.score).to be nil }
    end

    context 'when the answer is skipped' do
      let!(:answer) { create(:answer, question: question, skipped: true, submission: submission) }
      it { expect(answer.score).to be 0 }
    end
  end

  describe '#update_submission_total' do
    let(:question) { create(:question) }
    let(:option) { create(:option, score: 4, question: question) }
    let!(:submission) { create(:submission, competition: question.question_set.competition) }

    context 'when all answers have score' do
      before do
        create_list(:answer, 2,
                                text: option.text,
                                question: question,
                                submission: submission)
      end

      it { expect(submission.total).to be 8 }
      it { expect(submission.checked).to be true }
    end

    context 'when some answers do not have score' do
      let(:open_question) { create(:question) }
      before { submission.competition.question_sets << open_question.question_set }


      before do
        create(:answer,
                           text: option.text,
                           question: open_question,
                           submission: submission)
      end

      it { expect(submission.checked).to be false }
    end
  end
end

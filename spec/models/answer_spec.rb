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
        let(:answer) { create(:answer, option_id: correct.id, text: correct.text, question: question, submission: submission) }
        it { expect(answer.score).to be 1 }
      end

      context 'when the answer is incorrect' do
        let!(:answer) { create(:answer, option_id: incorrect.id, text: incorrect.text, question: question, submission: submission) }
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
                    option_id: option.id,
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
               question: open_question,
               submission: submission)
      end

      it { expect(submission.checked).to be false }
    end
  end

  describe 'custom validations' do
    describe 'question_option' do
      let(:question_set) { create(:question_set) }
      let!(:question) { create(:question, question_set: question_set) }
      let!(:open_question) { create(:question, question_set: question_set) }
      let!(:submission) { create(:submission, competition: question_set.competition) }
      let!(:option) { create(:option, question: question) }
      let!(:incorrect) { create(:option, question: create(:question)) }

      let(:answer1) { build(:answer, question: question, submission: submission, option_id: option.id, text: option.text) }
      let(:answer2) { build(:answer, question: question, submission: submission, option_id: incorrect.id) }
      let(:answer3) { build(:answer, question: open_question, submission: submission) }

      it { expect(answer1.save).to be true }
      it { expect(answer3.save).to be true }
      it { expect(answer2.save).to be false }
    end
  end
end

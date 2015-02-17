require 'rails_helper'

RSpec.describe Answer, :type => :model do
  describe '#set_score' do
    let!(:question) { FactoryGirl.create(:question) }

    describe 'on Quiz question' do
      let!(:correct) { FactoryGirl.create(:option, score: 1, question: question) }
      let!(:incorrect) { FactoryGirl.create(:option, score: 0, question: question) }

      context 'when the answer is correct' do
        let(:answer) { FactoryGirl.create(:answer, text: correct.text, question: question) }
        it { expect(answer.score).to be 1 }
      end

      context 'when the answer is incorrect' do
        let!(:answer) { FactoryGirl.create(:answer, text: incorrect.text, question: question) }
        it { expect(answer.score).to be 0 }
      end
    end

    describe 'on Open question' do
      let!(:answer) { FactoryGirl.create(:answer, question: question) }
      it { expect(answer.score).to be nil }
    end

    context 'when the answer is skipped' do
      let!(:answer) { FactoryGirl.create(:answer, question: question, skipped: true) }
      it { expect(answer.score).to be 0 }
    end
  end

  describe '#update_submission_total' do
    let(:question) { FactoryGirl.create(:question) }
    let(:option) { FactoryGirl.create(:option, score: 1, question: question) }
    let(:submission) { FactoryGirl.create(:submission) }

    context 'when all answers have score' do
      before do
        FactoryGirl.create_list(:answer, 2,
                                text: option.text,
                                question: question,
                                submission: submission)
      end

      it { expect(submission.total).to be 2 }
      it { expect(submission.checked).to be true }
    end

    context 'when some answers do not have score' do
      let(:open_question) { FactoryGirl.create(:question) }

      before do
        FactoryGirl.create(:answer,
                           text: option.text,
                           question: open_question,
                           submission: submission)
      end

      it { expect(submission.checked).to be false }
    end
  end
end

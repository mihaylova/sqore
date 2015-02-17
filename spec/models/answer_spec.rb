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
end

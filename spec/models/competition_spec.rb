require 'rails_helper'

RSpec.describe Competition, :type => :model do
  describe '#generate_report' do
    let(:competition) { create(:competition) }
    let(:user1) { create(:user_with_files) }
    let(:user2) { create(:user_with_files) }
    let(:user3) { create(:user) }
    let!(:submission1) { create(:submission, competition: competition, user: user1, total: 12) }
    let!(:submission2) { create(:submission, competition: competition, user: user2, total: 10) }
    let!(:submission3) { create(:submission, competition: competition, user: user3, checked: false) }
    let!(:fb_post) { create(:fb_post, user: user1, competition: competition) }

    let(:report) do
      [{ name: user1.name,
         email: user1.email,
         total: submission1.total,
         user_files: user1.files.map(&:url).join(', '),
         shares: 2,
         comments: 3 },
       { name: user2.name,
         email: user2.email,
         total: submission2.total,
         user_files: user2.files.map(&:url).join(', '),
         shares: 'no data',
         comments: 'no data' }
      ]
    end

    let(:fb_response) do
      { 'shares' => { 'data' => [1, 2] },
        'comments' => { 'data' => [1, 2, 3] }
      }
    end

    before do
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(fb_response)
    end

    it { expect(competition.generate_report).to eq report }
  end

  describe '#questions_ids' do
    let(:competition) { create(:competition) }
    let(:question_sets) { create_list(:question_set, 2, competition: competition) }
    let!(:questions_1) { create_list(:question, 2, question_set: question_sets.first) }
    let!(:questions_2) { create_list(:question, 3, question_set: question_sets.last) }

    it { expect(competition.question_ids).to eq (questions_1 + questions_2).map(&:id).sort }
  end
end

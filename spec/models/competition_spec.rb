require 'rails_helper'

RSpec.describe Competition, :type => :model do
  describe '#generate_report' do
    let(:competition) { create(:competition) }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let!(:submission1) { create(:submission, competition: competition, user: user1, total: 12) }
    let!(:submission2) { create(:submission, competition: competition, user: user2, total: 10) }
    let!(:submission3) { create(:submission, competition: competition, user: user3, checked: false) }

    let!(:user1_files) { create_list(:user_cloud_storage_file, 2, user: user1) }
    let!(:user2_files) { create_list(:user_cloud_storage_file, 2, user: user2) }
    let(:report) do
      [{ name: user1.name,
         email: user1.email,
         total: submission1.total,
         user_files: user1_files.map(&:url).join(', ') },
       { name: user2.name,
         email: user2.email,
         total: submission2.total,
         user_files: user2_files.map(&:url).join(', ') }
      ]
    end

    it { expect(competition.generate_report).to eq report }
  end
end

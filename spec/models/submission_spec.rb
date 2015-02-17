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
end

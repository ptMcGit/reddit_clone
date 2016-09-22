require 'rails_helper'

RSpec.describe VotePolicy do

  subject { described_class.new(user, vote) }
  before(:all) do
    @u      = create(:user)
    @p      = create(:post)
  end

  let(:vote) {
    create(
      :vote,
      user_id: @u.id,
      post_id: @p.id
    )
  }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to forbid_action(:vote) }
  end

  context 'being a regular user' do
    let(:user) { @u }

    it { is_expected.to permit_action(:vote) }
  end

  context 'being another user' do
    let(:user) { @u2 }

    it { is_expected.to forbid_action(:vote) }
  end

  context 'being an adiministrator' do
    let(:user) { @a }

    it { is_expected.to forbid_action(:vote) }
  end

end

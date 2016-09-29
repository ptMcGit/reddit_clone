require 'rails_helper'

RSpec.describe CommentPolicy do

  subject { described_class.new(user, comment) }
  before(:all) do
    @u      = create(:user)
    @u2     = create(:user)
    @a      = create(:user_who_is_admin)
  end

  before(:each) do
    @c = comment
  end

  let(:comment) {
    create(
      :comment,
      user_id: @u.id,
    )
  }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to forbid_action(:create) }

  end

  context 'being a regular user' do

    let(:user) { @u }

    it { is_expected.to permit_action(:create) }

  end

  context 'being another user' do
    let(:user) { @u2 }

    it { is_expected.to forbid_action(:create) }

  end

  context 'being an adiministrator' do
    let(:user) { @a }

    it { is_expected.to forbid_action(:create) }

  end

end

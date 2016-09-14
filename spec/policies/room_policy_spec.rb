require 'rails_helper'

RSpec.describe RoomPolicy do

  subject { described_class.new(user, room) }
  before(:all) do
    @u      = create(:user)
    @u2     = create(:user)
    @a      = create(:user_who_is_admin)
  end

  let(:room) {
    create(
      :room,
      user_id: @u.id,
    )
  }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to permit_action(:index) }

    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being an owner user' do
    let(:user) { @u }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'being another user' do
    let(:user) { @u2 }
    # index is redundant
    # show is redundant
    # new is redundant

    it { is_expected.to forbid_action(:edit) }

    # create is redundant

    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being an adiministrator' do
    let(:user) { @a }
    # index is redundant
    # show is redundant
    # new is redundant

    it { is_expected.to forbid_action(:edit) }

    # create is redundant

    it { is_expected.to forbid_action(:update) }

    it { is_expected.to permit_action(:destroy) }

  end

end

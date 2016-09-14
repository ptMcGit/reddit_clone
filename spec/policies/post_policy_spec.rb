require 'rails_helper'

RSpec.describe PostPolicy do

  subject { described_class.new(user, new_post) }
  before(:all) do
    @u      = create(:user)
    @r      = create(:room)
    @u2     = create(:user)
    @a      = create(:user_who_is_admin)
  end

  let(:new_post) {
    create(
      :post,
      user_id: @u.id,
      room_id: @r.id
    )
  }

  context 'being a visitor' do
    let(:user) { nil }

    xit { is_expected.to forbid_action(:index) }
    xit { is_expected.to forbid_action(:show) }
    xit { is_expected.to forbid_action(:new) }
    xit { is_expected.to forbid_action(:edit) }
    xit { is_expected.to forbid_action(:create) }
    xit { is_expected.to forbid_action(:update) }
    xit { is_expected.to forbid_action(:destroy) }
  end

  context 'being a regular user' do
    let(:user) { @u }

    it { is_expected.to forbid_action(:index) }

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
    it { is_expected.to permit_action(:show) }

    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being an adiministrator' do
    let(:user) { @a }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }

    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }

    it { is_expected.to permit_action(:destroy) }
  end

end

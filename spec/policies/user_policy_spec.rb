require 'rails_helper'

RSpec.describe UserPolicy do

  subject { described_class.new(user, user) }
  before(:all) do
    @u      = create(:user)
    @a      = create(:user_who_is_admin)
  end

  let(:user) {
    create(
      :user
    )
  }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    # new handled by devise
    # edit handled by devise
    # create handled by devise
    # update handled by devise
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being a regular user' do
    let(:user) { @u }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:show) }
    # new handled by devise
    # edit handled by devise
    # create handled by devise
    # update handled by devise
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being another user' do
    # not necessary
  end

  context 'being an adiministrator' do
    let(:user) { @a }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    # new handled by devise
    # edit handled by devise
    # create handled by devise
    # update handled by devise
    it { is_expected.to permit_action(:destroy) }
  end

end

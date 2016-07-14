require 'rails_helper'
#include Devise::TestHelpers

RSpec.describe RoomsController, type: :controller do
  let(:user) { create :user }
  let(:room) { create :room }
  it "renders the index template" do
    get :index
    expect(response.status).to eq(200)
    binding.pry
  end

  it "renders the show template" do
    u = user
    r = room
    sign_in u

    get :show, id: 1
    expect(response.status).to eq(200)
  end

end

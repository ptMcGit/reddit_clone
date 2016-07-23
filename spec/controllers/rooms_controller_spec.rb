require 'rails_helper'
#include Devise::TestHelpers

RSpec.describe RoomsController, type: :controller do
  let(:user) { create(:user, password: "password") }
  let(:room) { create :room }
  it "renders the index template" do
    get :index
    expect(response.status).to eq(200)
  end

  it "renders the show template" do
    u = user
    r = room
    sign_in u

    get :show, id: 1
    expect(response.status).to eq(200)
  end

  it "can create a room" do
    u = user
    sign_in u

    expect {
      post :create, {
             room: {name: "test room",
                    description: "test room description"}
           }
    }.
      to change { Room.count }.by 1
  end

  it "can destroy a room" do
    r = room
    sign_in r.user

    expect {
    post :destroy, {
           id: r.id
         }
    }.
      to change { Room.count }.by -1
  end

  it "cannot destroy rooms it does not own" do
    r = room
    u = user

    sign_in u

    expect {
    post :destroy, {
           id: r.id
         }
    }.
      to change { Room.count }.by 0
    expect(response).to redirect_to("/404")
  end
end

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  before(:all) do
    @u      = create(:user)
    @a      = create(:user_who_is_admin)
  end

  let(:room) {
    create(
      :room,
      user_id: @u.id
    )
  }

  describe "regular users" do
    before(:each) do
      sign_in @u
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "renders the show template" do
      r = room
      get :show, id: r.id
      expect(assigns(:room)).to eq(r)
      expect(response).to render_template(:show)
    end

    it "renders the new template" do
      get :new
      expect(assigns(:room)).to be_a_new(Room)
      expect(response).to render_template(:new)
    end

    it "can create a room" do
      expect {
        post :create, {
               room: {
                 **(attributes_for(:room))
               }
             }
      }.
        to change { Room.count }.by 1
    end

    it "can update a room" do
      r = room
      old_attr = r.attributes

      post :update, {:id => r.id, :room => {
             **(attributes_for(:room))
           }}

      expect(assigns(:room)).to eq(r)
      expect(r.reload.attributes).to_not eq(old_attr)
    end

    it "can destroy a room" do
      r = room

      post :destroy, {
             :id => r.id
           }
      expect(assigns(:room)).to eq(r)
      expect(Room.find_by(id: r.id)).to be_falsy
    end
  end

  describe "administrators" do
    before(:each) do
      sign_in @a
    end

    it "can destroy rooms owned by others" do
      r = room

      post :destroy, {
             id: r.id
           }

      expect(assigns(:room)).to eq(r)
      expect(Room.find_by(id: r.id)).to be_falsy
    end
  end

  describe "moderators" do
    "can quit as moderator"
  end
end

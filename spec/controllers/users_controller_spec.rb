require 'rails_helper'

describe UsersController, type: :controller do

  before(:all) do
    @u      = create(:user)
    @a      = create(:user_who_is_admin)
  end

  let(:user) {
    create(
      :user
    )
  }

  describe "regular users" do

    before(:each) do
      sign_in @u
    end

    it "renders the show template" do
      get 'show', id: @u.id
      expect(assigns(:user)).to eq(@u)
      expect(response).to render_template(:show)
    end

  end

  describe "administrators" do

    before(:each) do
      sign_in @a
    end

    it "renders the index template" do
      2.times { user }
      get :index
      expect(assigns(:users).count).to eq(User.count)
      expect(response).to render_template(:index)
    end

    it "can destroy other users" do
      u = user

      post :destroy, {
             id: u.id,
           }
      expect(assigns(:user)).to eq(u)
      expect(User.find_by(id: u.id)).to be_falsy
    end

  end

  describe "moderators" do
    "can delete posts in rooms it moderates."
    "can view all posts for rooms it moderates."
  end

end

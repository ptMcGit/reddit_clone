require 'rails_helper'

describe PostsController, type: :controller do

  let(:user) { create :user }
  let(:admin) { create :user_who_is_admin }
  let(:room_post) { create :post }
  let(:room) { create :room }

  describe "administrators" do
    it "can delete other user's posts" do
      p = room_post
      a = admin
      sign_in a

      expect {
        post 'destroy', {id: p.id, room_id: p.room_id}
      }.
        to change { Post.count }.by -1
    end

    it "are the only ones who see the index" do
      bypass_rescue

      a = admin
      sign_in a

      get 'index'
      expect(response.status).to eq(200)
      sign_out a

      u = user
      sign_in u
      expect {
        get 'index'
        }.
        to raise_error(Pundit::NotAuthorizedError)
    end
  end

  describe "regular users" do
    def log_in_user
      u = user
      sign_in u
    end

    before(:each) do
      log_in_user
    end

    it "renders the show template" do
      p = room_post

      get 'show', id: p.id
      expect(response).to render_template(:show)
      expect(response.status).to eq(200)
    end

    it "allows creation of a new post" do
      r = room

      new_room_post_path(r.id)
      expect(response.status).to eq(200)
      #expect(assigns(:post)).to be_a_new(Post)
    end

    it "renders the edit view" do
      p = room_post
      sign_in p.user
      get 'edit', id: p.id
      expect(response).to render_template(:edit)
      expect(response.status). to eq(200)
    end

    it "can create posts" do
      r = room
      u = user
      sign_in u
      expect {
        post 'create', {
               room_id: r.id,
               user_id: u.id,
               title: "title",
               content: "content"
             }
      }.
        to change { Post.count }.by 1


    end

    it "allows a user to update a post" do
      p = create :post, {updated_at: 1.day.ago}

      sign_in p.user

      post 'update', {id: p.id, content: "content update", user_id: p.user_id, title: "title update"}
      p_new = Post.find(p.id)
      expect p_new.updated_at == p.updated_at
    end

    it "allows a user to destroy a post" do
      p = create :post

      sign_in p.user

      expect {
        post 'destroy', {id: p.id, room_id: p.room_id}
      }.
        to change { Post.count }.by -1
    end
  end

  describe "other users" do
    it "cannot delete a post that doesn't belong to them" do
      bypass_rescue
      p = room_post
      other_u = user
      sign_in other_u
       expect {
        post 'destroy', {id: p.id, room_id: p.room_id}
      }.
        to raise_error(Pundit::NotAuthorizedError)
    end

    it "cannot edit a post that doesn't belong to them" do
      bypass_rescue
      p = create :post, {updated_at: 1.day.ago}
      u = user
      sign_in u

      expect {
       post 'update', {id: p.id, content: "content update", user_id: p.user_id, title: "title update"}
      }.
       to raise_error(Pundit::NotAuthorizedError)

      p_new = Post.find(p.id)
      expect p_new.updated_at != p.updated_at
    end
  end

  describe "moderators" do
    it "can delete posts in rooms it moderates."
  end
end

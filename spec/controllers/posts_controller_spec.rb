require 'rails_helper'

describe PostsController, type: :controller do

  before(:all) do
    @u      = create(:user)
    @r      = create(:room)
    @a      = create(:user_who_is_admin)
  end

  let(:new_post) {
    create(
      :post,
      user_id: @u.id,
      room_id: @r.id,
    )
  }

  describe "regular users" do

    before(:each) do
      sign_in @u
      @p = new_post
    end

    it "renders the show template" do
      get 'show', id: @p.id
      expect(assigns(:post)).to eq(@p)
      expect(response).to render_template(:show)
    end

    it "renders the new view" do
      get 'new', room_id: @r.id
      expect(assigns(:post)).to be_a_new(Post).with(:room_id => @r.id)
      expect(response).to render_template(:new)
    end

    it "renders the edit view" do
      get 'edit', id: @p.id
      expect(response).to render_template(:edit)
      expect(assigns(:post)).to eq(@p)
    end

    it "can create posts" do
      expect {
        post 'create', {
               room_id: @r.id,
               user_id: @u.id,
               **(attributes_for(:post))
             }
      }.
        to change { Post.count }.by 1
    end

    it "allows a user to update a post" do
      old_attr = @p.attributes

      post 'update', {
               id: @p.id,
               user_id: @p.user_id,
               **(attributes_for(:post))
           }

      expect(assigns(:post)).to eq(@p)
      expect(@p.reload.attributes).to_not eq(old_attr)
    end

   it "allows a user to destroy a post" do
     post 'destroy', {
            id: @p.id,
            room_id: @p.room_id
          }

     expect(assigns(:post)).to eq(@p)
     expect(Post.find_by(id: @p.id)).to be_falsy
    end
  end

  describe "administrators" do
    before(:each) do
      sign_in @a
    end

    it "renders the index template" do
      new_post
      sign_in @a
      get 'index'
      expect(assigns(:posts).last).to eq(Post.last)
      expect(assigns(:posts).count).to eq(Post.count)
      expect(response).to render_template(:index)
    end

    it "can destroy others' posts" do
      p = new_post

      post 'destroy', {
             id: p.id,
            room_id: p.room_id
          }
     expect(assigns(:post)).to eq(p)
     expect(Post.find_by(id: p.id)).to be_falsy
    end

  end

  describe "moderators" do
    "can delete posts in rooms it moderates."
    "can view all posts for rooms it moderates."
  end

end

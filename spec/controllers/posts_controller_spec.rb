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

    it "see the show template" do
      get 'show', id: @p.id
      expect(assigns(:post)).to eq(@p)
      expect(response).to render_template(:show)
    end

    it "see the new view" do
      get 'new', room_id: @r.id
      expect(assigns(:post)).to be_a_new(Post).with(:room_id => @r.id)
      expect(response).to render_template(:new)
    end

    it "see the edit view" do
      get 'edit', id: @p.id
      expect(response).to render_template(:edit)
      expect(assigns(:post)).to eq(@p)
    end

    it "can create posts" do
      expect {
        post 'create', {
               post: {
                 **(attributes_for(:post))
               },
               room_id: @r.id
             }
      }.
        to change { Post.count }.by 1
    end

    it "can update a post" do
      old_attr = @p.attributes

      post 'update', {
             post: {
               **(attributes_for(:post))
             }, id: @p.id
           }

      expect(assigns(:post)).to eq(@p)
      expect(@p.reload.attributes).to_not eq(old_attr)
    end

   it "can destroy a post" do
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
      2.times { new_post }
      get 'index'
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

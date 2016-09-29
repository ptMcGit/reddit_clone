require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:all) do
    @u  = create(:user)
    @r  = create(:room)
    @p  = create(:post,
                 user_id: @u.id,
                 room_id: @r.id
                )
  end

  let(:comment_on_post) {
    create(
      :comment,
      user_id: @u.id,
      commentable_id: @p.id,
      commentable_type: 'Post'
    )
  }


  describe "regular users" do

    before(:each) do
      sign_in @u
    end

    it "can comment on posts" do
      request.env["HTTP_REFERER"] = root_path
      expect {
        post 'create', {comment: {
                          commentable_id:      @p.id,
                          commentable_type:    'Post',
                          **(attributes_for(:comment))
                        },
                        post_id: @p.id

                       }
      }.
        to change { @p.reload.comments.count }.by 1
    end

    it "can comment on comments" do
      request.env["HTTP_REFERER"] = root_path
      c = comment_on_post
      expect {
        post 'create', {comment: {
                          commentable_id:      c.id,
                          commentable_type:    'Comment',
                          **(attributes_for(:comment))
                        },
                        post_id: @p.id
                       }
      }.
        to change { c.reload.comments.count }.by 1
    end

    it "can update comment" do
      c = comment_on_post
      binding.pry
      old_attr = c.attributes

      post 'update', {comment: {
                        commentable_id:       c.id,
                        commentable_type:     'Comment',
                        **(attributes_for(:comment))
                      },
                      id: c.id
                     }
      expect(assigns( :comment )).to eq( c )
      expect(c.reload.attributes).to_not eq(old_attr)
    end

  end

end

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:all) do
    @u  = create(:user)
    @r  = create(:room)
    @p  = create(:post)
  end

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

end

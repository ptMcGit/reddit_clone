require 'rails_helper'

describe Post, type: :model do
  before(:each) do
    @p  = create(:post)
  end

  def comment_on_post(c, t=Time.now)
    create(
      :comment,
      commentable_id:       c.id,
      commentable_type:     "Post",
      created_at:           t
    )
  end

  def comment_on_comment(c, t=Time.now)
    create(
      :comment,
      commentable_id:       c.id,
      commentable_type:     "Comment",
      created_at:           t
    )
  end

  it "can sum up the total votes" do
    v = create :vote, value: 1
    create :vote, post_id: v.post_id, value: 1
    create :vote, post_id: v.post_id, value: 1
    create :vote, post_id: v.post_id, value: -1

    p = Post.find(v.post_id)
    expect(p.sum).to eq 2
  end

  it "#all_comments returns with nesting as expected" do
    expect([
             c1 = comment_on_post(          @p ),
             c1_1 = comment_on_comment(     c1 ),
             c1_1_1 = comment_on_comment(   c1_1 ),
             c1_1_2 = comment_on_comment(   c1_1 ),
             c1_2 = comment_on_comment(     c1 ),
             c1_3 = comment_on_comment(     c1 ),
             c1_3_1 = comment_on_comment(   c1_3),
             c2 = comment_on_post(          @p ),
             c3 = comment_on_post(          @p )
           ]).to eq(
                   @p.all_comments.to_a
                 )
  end

  it "#all_comments returns only its own comments" do
    c1 = comment_on_post( @p )
    p2 = create(:post)
    p2c1 = comment_on_post( p2 )
    expect(@p.all_comments).to eq( [c1] )
  end

end

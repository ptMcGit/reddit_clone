require 'rails_helper'

describe Post, type: :model do
  include_context "shared_comments"

  before(:each) do
    @p  = create(:post)
  end

  def upvote
    create(
      :vote,
      post_id: @p.id,
      value: 1,
      user_id: build(:user).id
    )
  end

  def downvote
    create(
      :vote,
      post_id: @p.id,
      value: -1,
      user_id: build(:user).id
    )
  end

  it "can sum up the total votes" do
    votes = []

    5.times do
      votes.push(
        send( [:upvote, :downvote].sample ).value
      )
    end

    expect(@p.sum).to eq( votes.reduce(:+) )
  end

  it "#all_comments returns with nesting as expected" do
    expect( random_comments(@p) ).to eq(@p.all_comments)
  end

  it "#all_comments returns only its own comments" do
    c1 = comment_on_post( @p )
    p2 = create(:post)
    p2c1 = comment_on_post( p2 )
    p2c1_1 = comment_on_comment( p2c1 )
    expect(@p.all_comments).to eq( [c1] )
  end

end

require 'rails_helper'

describe Post, type: :model do
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

  def comment_on_post(c)
    create(
      :comment,
      commentable_id:       c.id,
      commentable_type:     "Post",
    )
  end

  def comment_on_comment(c)
    create(
      :comment,
      commentable_id:       c.id,
      commentable_type:     "Comment",
    )
  end

  def klass(instance)
    instance.class.table_name.classify
  end

  def random_comments( post=create(:post), limit=10 )
    count = 0
    commentables = {0 => post}
    results = []

    limit.times do
      nesting_lvl = commentables.keys.sample
      sample = commentables[ nesting_lvl ]
      nesting_lvl += 1

      results.push(
        commentables[ nesting_lvl ] =
        create(
          :comment,
          commentable_id: sample.id,
          commentable_type: klass(sample)
        )
      )
      commentables.select! { |k,v| k <= nesting_lvl }

    end
    results
  end

  it "can sum up the total votes" do
    users = (1..5).to_a.each do
      create(:user)
    end

    votes = []
    5.times do
      votes.push(
        send( [:upvote, :downvote].sample ).value
      )
      binding.pry
    end
    binding.pry
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

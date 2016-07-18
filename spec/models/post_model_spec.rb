require 'rails_helper'

describe Post, type: :model do

  it "can sum up the total votes" do
    v = create :vote, value: 1
    create :vote, post_id: v.post_id, value: 1
    create :vote, post_id: v.post_id, value: 1
    create :vote, post_id: v.post_id, value: -1

    p = Post.find(v.post_id)
    expect(p.sum).to eq 2
  end
end

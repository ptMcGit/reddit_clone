require 'rails_helper'

describe VotesController, type: :controller do

  before(:all) do
    @u      = create(:user)
    @p      = create(:post)
    @r      = create(:room)
    @headers = { "ACCEPT" => "application/json" }
  end

  let(:new_post) {
    create(
      :post,
      user_id: @u.id,
      room_id: @r.id
    )
  }

  describe "regular users" do

    before(:each) do
      sign_in @u
    end

    it "can vote for the first time" do
      p = new_post

      expect {
        post 'vote', {
               value: 1,
               post_id: p.id
             },
             @headers
      }.
        to change { Vote.count }.by 1
      expect(response.content_type).to eq("application/json")
      expect(response.body).to include("ok")
    end

    it "can change vote" do
      v = create(
        :vote,
        user_id: @u.id,
        post_id: @p.id,
        value: 1
      )
      orig_val = v.value

      post 'vote', {
             value: v.value * -1,
             post_id: v.post_id
           },
           @headers

      expect( v.reload.value ).to eq (orig_val * -1)
      expect(response.content_type).to eq("application/json")
      expect(response.body).to include("ok")
    end
  end
end

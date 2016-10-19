require 'rails_helper'

describe "RoomOwners", type: :feature do

  before(:all) do
    @u  = create(:user)
  end

  let(:room) {
    create(
      :room,
      user_id: @u.id
    )
  }

  before(:each) do
    login_as(@u, :scope => :user)
  end

  it "can create a room" do
    @r = attributes_for(:room)

    visit "/"

    click_on "Create Room"
    expect(current_path).to eq(new_room_path)

    fill_in "room_name",            with: @r[:name]
    fill_in "room_description",     with: @r[:description]
    click_on "Submit"

    expect(current_path).to eq(room_path(Room.last.id))
  end



  it "can create room moderators"
  it "can demote room moderators"
  it "can ban a user"
  it "can remove a post"
  it "can remove a comment"
  it "can quit as moderator"
  it "can quit as owner"
  it "can delete room as owner"
  it "can pass ownership of room"
end

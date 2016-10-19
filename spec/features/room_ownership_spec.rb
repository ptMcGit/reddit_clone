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

    expect {
      fill_in "room_name",            with: @r[:name]
      fill_in "room_description",     with: @r[:description]
      click_on "Submit"
    }.to change { Room.count }.by 1

    expect(current_path).to eq(room_path(Room.last.id))
  end

  it "can edit a room" do
    @r =    room
    @r2 =   attributes_for(:room)
    visit "/"

    within "table" do
      click_link @r.name
    end

    expect(current_path).to eq(room_path( @r.id ))

    click_on("Edit Room")
    expect(current_path).to eq(edit_room_path( @r.id ))

    fill_in "room_name",        with: @r2[:name]
    fill_in "room_description", with: @r2[:description]
    click_on("Submit")

    @r.reload

    # @r is equal to @r2
    expect(
      @r2.find { |k| @r[k.to_s] != @r2[k] }
    ).to be_falsy

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

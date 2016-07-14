require 'rails_helper'
require 'pry'

describe "RegisteredUser", type: :feature do

  let(:room) { create :room }
  let(:user) { create :user }
  let(:post) { create :post }

  def log_in
    visit "/"
    click_on "Log In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
  end

  before(:each) do
    log_in
  end

  xit "can create post" do
    post_title = "Test post title"
    post_content = "Test post content"

    expect {
      visit rooms_path
      visit room_path(room.id)

      click_on "New Post"

      fill_in "Title", with: post_title
      fill_in "Content", with: post_content
      click_on "Submit"
    }.
      to change { Post.count }.by 1

    expect(page).to have_content post_title
  end

  it "can edit a post less than an hour old"
  it "cannot edit a post more than an hour old"
  xit "can delete a post" do
    p = create(:post, title: "can delete a post test")
    visit rooms_path
  end
end

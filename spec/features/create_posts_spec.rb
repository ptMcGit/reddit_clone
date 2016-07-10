require 'rails_helper'
require 'pry'

describe "RegularUser", type: :feature do

  let(:room) { create :room }
  let(:user) { create :user }

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

  it "can create post" do
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
    save_and_open_page
  end
end

require 'rails_helper'
require 'pry'

describe "RegisteredUser", type: :feature do

  before(:all) do
    @u      = create(:user)
    @r      = create(:room)
  end

  let(:new_post) {
    create(
      :post,
      user_id: @u.id,
      room_id: @r.id
    )
  }

  def log_in
  end

  describe "logged out user" do

    it "can log in" do
      visit "/"
      click_on "Log In"
      fill_in "Email",    with: @u.email
      fill_in "Password", with: @u.password
      click_on "Log in"
      expect(current_path).to eq(root_path)
    end

  end

  describe "logged in user" do

    before(:each) do
      login_as(@u, :scope => :user)
    end

    it "can create post" do
      @p = attributes_for(:post)

      visit room_path(@r.id)
      has_link?('New Post')

      click_on "New Post"
      expect(current_path).to eq( new_room_post_path(@r.id) )

      fill_in "post_title", with:    @p[:title]
      fill_in "post_content", with:  @p[:content]
      click_on "Submit"
      expect(current_path).to eq(room_path(@r.id))

      within("#posts-table") do
        has_link?(@p[:title])
        has_link?(@u.username)
      end

    end

    it "can edit post"


    it "cannot edit a post more than an hour old"
    xit "can delete a post" do
      p = create(:post, title: "can delete a post test")
      visit rooms_path
    end
  end
end

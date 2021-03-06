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

    it "can edit post" do
      @p = new_post
      @p2 = attributes_for(:post)

      visit room_path(@r.id)
      has_link?(@p.title)

      click_on(@p.title)
      expect(current_path).to eq( post_path(@p.id) )

      has_link?('Edit Post')
      click_on('Edit Post')
      expect(current_path).to eq( edit_post_path(@p.id) )

      fill_in "post_title", with:   @p2[:title]
      fill_in "post_content", with: @p2[:content]
      click_on "Submit"

      @p.reload
      expect(current_path).to eq( room_path(@r.id) )
      expect(@p.title).to eq(@p2[:title])
      expect(@p.content).to eq(@p2[:content])
    end

    it "can delete a post" do
      @p = new_post

      visit room_path(@r.id)
      has_link?(@p.title)

      click_on(@p.title)
      expect(current_path).to eq( post_path(@p.id) )

      has_link?('Delete Post')

      click_on('Delete Post')
      expect(current_path).to eq( room_path(@r.id) )
      ! has_link?( edit_post_path(@p.id) )
    end
  end
end

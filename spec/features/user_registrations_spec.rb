require 'rails_helper'
require 'pry'

describe "Registration", type: :feature do
  describe "unregistered user" do
    it "can become a regular user" do
      @u = attributes_for(:user, password: "password")

      visit "/"

      click_on "Sign Up"

      expect(current_path).to eq(new_user_registration_path)

      within("form#new_user") do
        fill_in "user[username]",                 with: @u[:username]
        fill_in "user[email]",                    with: @u[:email]
        fill_in "user[password]",                 with: @u[:password]
        fill_in "user[password_confirmation]",    with: @u[:password]
        click_on "Sign up"
      end

      expect( User.find_by(email: @u[:email]) ).to be_truthy
      expect(current_path).to eq(root_path)
      has_link? "Log Out"
    end
  end

  describe "registered user" do

    before(:each) do
      @u = create(:user, password: "password")
    end

    it "can log in and log out" do
      visit "/"

      click_on "Log In"
      expect(current_path).to eq(new_user_session_path)

      fill_in "Email",    with: @u.email
      fill_in "Password", with: @u.password

      click_on "Log in"
      expect(current_path).to eq(root_path)

      click_on "Sign Out"
      expect(current_path).to eq(root_path)
    end

    xit "can cancel account" do
      login_as(@u, :scope => :user)
      visit "/"

      click_on "Account Settings"
      expect(current_path).to eq(edit_user_registration_path)

      click_on "Cancel my account"

      expect( Find_by(id: @u.id) ).to be_falsy
      expect(current_path).to eq(root_path)
    end
  end

end

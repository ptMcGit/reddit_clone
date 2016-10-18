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
  end

end

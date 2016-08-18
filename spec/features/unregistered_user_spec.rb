require 'rails_helper'
require 'pry'

describe "SignUp", type: :feature do
 it "can become a regular user" do
    expect {
      visit "/"
      click_on "Sign Up"
      fill_in "user[username]", with: "testuser"
      fill_in "user[email]", with: "test@example.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_on "Sign up"
    }.
      to change { User.count }.by 1
    expect(current_path).
      to eq(root_path)
  end
end

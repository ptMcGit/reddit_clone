require 'rails_helper'
require 'pry'

describe "UnregisteredUsers", type: :feature do
  it "can create a user account" do
    expect {
      visit "/"
      click_on "Sign Up"
      fill_in "user[email]", with: "test@example.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_on "Sign up"
    }.
      to change { User.count }
    binding.pry
    expect(current_path). to eq(rooms_path)
  end
end

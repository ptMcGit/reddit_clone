require 'rails_helper'
require 'pry'

feature "SigningIn", type: :feature do
it "can create a user account" do
  visit "/"
    save_and_open_page
end
end

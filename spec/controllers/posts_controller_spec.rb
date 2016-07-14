require 'rails_helper'

describe PostsController, type: :controller do
  let(:user) { create :admin }
  let(:admin) { create :admin }

  xit "renders index for admins only" do
    august = user
    sign_in august
    get 'index'
  end


  xit "renders the show template" do
    u = user
    sign_in u
    get 'index'
    expect(response.status).to eq(200)
  end

  xit "shows the page" do
    get 'show'
    expect(response.status).to eq(200)
  end

end

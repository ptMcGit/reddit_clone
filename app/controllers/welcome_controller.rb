class WelcomeController < ApplicationController
  skip_before_action  :authenticate_user!, only: [:index]   # whitelist only these
  def index
  end
end

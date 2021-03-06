# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'devise'
require 'pundit/rspec'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Warden::Test::Helpers

  config.include Devise::Test::ControllerHelpers, :type => :controller
  #config.before :each, type: :controller do
    #@request.env["devise.mapping"] = Devise.mappings[:user]
    #@request.env["devise.mapping"] = Devise.mappings[:admin]
    #binding.pry
  #end
  config.include FactoryGirl::Syntax::Methods

  # require everything in spec/support
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
end

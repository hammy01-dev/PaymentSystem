
ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include Devise::Test::IntegrationHelpers

  # Add more helper methods to be used by all tests here...
end

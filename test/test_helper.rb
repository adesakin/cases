ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# require "minitest/autorun"
require "minitest/rails/capybara"
require 'minitest-metadata'
require 'simplecov'
# require 'capybara/rails'
require 'capybara/poltergeist'


SimpleCov.start
Capybara.app_host = 'http://localhost:3002'


class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  include Capybara::Assertions
  include MiniTest::Metadata

  Capybara.javascript_driver = :poltergeist
  self.use_transactional_fixtures = false

  before :each do
    Capybara.reset_sessions!
    @request.host = 'http://localhost:3002'
    if metadata[:js]
      Capybara.current_driver = Capybara.javascript_driver
    else
      Capybara.current_driver = Capybara.default_driver
    end
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  def user_sign_in
    @user = create(:user, password: "secretkey", email: "sample@test.cases.com")
    visit '/'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on "Sign in"
  end

end


class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  extend MiniTest::Spec::DSL

  register_spec_type self do |desc|
    desc < ActiveRecord::Base if desc.is_a? Class
  end

  def user_sign_in
    @user = create(:user, password: "secretkey", email: "sample@test.cases.com")
    sign_in @user
  end

  class ActionController::TestCase
    include Devise::TestHelpers
  end
end

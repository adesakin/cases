ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# require "minitest/autorun"
require "minitest/rails"
require "minitest/rails/capybara"
require 'minitest-metadata'
require 'simplecov'
# require 'capybara/rails'
require 'capybara/poltergeist'



SimpleCov.start
Capybara.app_host = 'http://localhost:3002'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true)
end





# class ActiveRecord::Base
#   mattr_accessor :shared_connection
#   @@shared_connection = nil
#   def self.connection
#     @@shared_connection || retrieve_connection
#   end
# end
# ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection


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

  class ActionDispatch::IntegrationTest
    # Make the Capybara DSL available in all integration tests
    include Capybara::DSL
    include Capybara::Assertions
    include MiniTest::Metadata

    include Warden::Test::Helpers
    Warden.test_mode!

    Capybara.javascript_driver = :poltergeist
    #self.use_transactional_fixtures = true

    def teardown
      Capybara.current_driver = nil
      Capybara.reset_sessions!
    end


    def user_sign_in(user=nil)
      @user = user || FactoryGirl.create(:user, password: "secretkey", email: "sample@test.cases.com")
      visit '/'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on "Sign in"
    end

    def js_sign_in
      visit root_path
      fill_in "Email", with: users(:one).email
      fill_in "Password", with: "password.Simple"
      click_on('Sign in')
    end

    def wait_for_ajax
      counter = 0
      while page.evaluate_script("$.active").to_i > 0
        counter += 1
        sleep(0.1)
        raise "AJAX request took longer than 5 seconds." if counter >= 50
      end
    end



    def sign_in(user)
      login_as(user, scope: :user)
    end

    def sign_out
      logout(:user)
    end

  end
end

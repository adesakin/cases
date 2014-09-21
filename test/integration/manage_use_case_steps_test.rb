require 'test_helper'

class ManageUseCaseStepsTest < ActionDispatch::IntegrationTest
  def setup
    @use_case = create(:use_case)
    user_sign_in
    visit root_path
    find('ul#projects', text: 'Test Project').click_link(@use_case.project.name)
    find('ul#project_use_cases').click_link(@use_case.name)
  end

  def teardown

  end

  test "access a use case to create standard flow step" do
    find('#standard_flows').click_link('Add a Step')

  end
end

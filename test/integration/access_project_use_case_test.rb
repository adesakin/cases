require 'test_helper'

class AccessProjectUseCaseTest < ActionDispatch::IntegrationTest
  def setup
    @use_case = create(:use_case)
    user_sign_in
    visit root_path
    find('ul#projects', text: 'Test Project').click_link(@use_case.project.name)
  end

  def teardown

  end

  test 'access project specific page with use cases listed' do
  	
  	URI.parse(current_url).request_uri.must_equal project_path(@use_case.project)
  	@use_cases = @use_case.project.use_cases
  	use_case_rows = page.all('ul#project_use_cases li.use_case_id')
  	@use_cases.count.must_equal use_case_rows.count
  end

  test 'create a use case from project list page' do
  	click_on('New Use Case')
  	URI.parse(current_url).request_uri.must_equal new_project_use_case_path(@use_case.project)
    @use_case_2 = UseCase.new(name: "View Use Case Diagram", description: "As a user I want to view use case diagram", \
      standard_flow: "1. Click on the desired use case to reveal its details and diagram thumbnail. 2. Click on a thumbnail.")
    click_on 'Save'
    page.must_have_css('#error_explanation')
    fill_in 'Name', with: @use_case_2.name
    fill_in 'Description', with: @use_case_2.description
    fill_in 'Standard flow', with: @use_case_2.standard_flow
    click_on 'Save'
    page.wont_have_css('#error_explanation')

    #carry on testing that use case was created
  end

  test 'return to project use cases after accessing its details' do
    find('ul#project_use_cases').click_link(@use_case.name)
    click_link('Back to Use Cases')
    current_path.must_equal  project_path(@use_case.project)
  end


  test 'return to project use cases after click on new' do
    click_on('New Use Case')
    click_link('Back to Use Cases')
    current_path.must_equal  project_path(@use_case.project)
  end

  test 'use case has sub-section for documents' do
    find('ul#project_use_cases').click_link(@use_case.name)
    within(:css, '#right-yield') do
      page.must_have_css('.tabs', text: 'Documents' )
      find('.tabs', text: 'Documents' ).click

    end

  end

  # test "the truth" do
  #   assert true
  # end
end

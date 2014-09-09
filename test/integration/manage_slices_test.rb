require 'test_helper'
include Warden::Test::Helpers
Warden.test_mode!

class ManageSlicesTest < ActionDispatch::IntegrationTest

  def setup

  end


  def teardown

  end

  test 'populate slices' do
    Capybara.current_driver = Capybara.javascript_driver
    js_sign_in
    @project = Project.first
    @use_case = @project.use_cases.first
    find('table#projects', text: @project.name).click_link(@project.name)
    find('table#project_use_cases').click_link(@use_case.name)
    find('#right-yield dd', text: 'Slices').click
    #page.evaluate_script('$.getScript($("a.slice-add.btn").attr("href"))')
    find('a.slice-add.btn').click
    wait_for_ajax
    uc_step = @use_case.steps.order('custom_id ASC').first
    page.find('#standard_flows td', text: uc_step.description).drag_to(page.find('#slice-panel tr'))
    slice_count = Slice.count
    find('a.btn', text: 'Save Slice').click
    wait_for_ajax
    slice_count.must_equal (Slice.count + 1)
    @use_case.slices.must_include uc_step
    page.must_have_content

    save_and_open_page



  end

end
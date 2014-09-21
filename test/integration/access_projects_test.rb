require 'test_helper'

class AccessProjectsOverviewTest < ActionDispatch::IntegrationTest
  def setup
    @use_case = create(:use_case)
    user_sign_in
  end

  def teardown
    Capybara.current_driver = Capybara.default_driver
  end

  test "access root page to view projects" do
  	visit root_path
  	find_link('New Project').visible?
    @projects = Project.all
    project_ids = projects_listed
    project_ids.count.must_equal @projects.count
    project_ids.sort.must_equal @projects.sort.map {|p| p.id.to_s}
  end

  test 'return to projects listing after accessing a use_case' do
    find('ul#projects', text: 'Test Project').click_link(@use_case.project.name)
    find('#header').click_link('Projects')
    current_path.must_equal home_index_path
  end


  test "create project from root page without leaving" do
    Capybara.current_driver = Capybara.javascript_driver
    js_sign_in   
    page.evaluate_script "window.notReloaded = true" #initial a new variable on page
    init_listed = projects_listed
    find_link('New Project').click
    wait_for_ajax
    fill_in "project_name", with: "Project Tester"
    save_and_open_page()
    page.execute_script("$('form.new_project').submit()")
    wait_for_ajax
    save_and_open_page()
    page.evaluate_script("window.notReloaded").must_equal true
    final_listed = projects_listed
    puts "#{final_listed.count}"
    final_listed.count.must_equal (init_listed.count + 1)

    #fill in details and ensure project is created.
  end

  def projects_listed
    page.all('ul#projects li.project_id').map(&:text)
  end


  # test "the truth" do
  #   assert true
  # end
end

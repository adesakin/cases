require 'test_helper'

class AccessProjectsOverviewTest < ActionDispatch::IntegrationTest
  def setup
    @use_case = create(:use_case)
    user_sign_in
  end

  def teardown

  end

  test "access root page to view projects" do
  	visit root_path
  	find_link('New Project').visible?
    #create_list(:project, 2)
    @projects = Project.all
    project_ids = page.all('table#projects td.project_id').map(&:text)
    project_ids.count.must_equal @projects.count
    project_ids.sort.must_equal @projects.sort.map {|p| p.id.to_s}
  end

  it "create project from root page without leaving", :js => true do
    skip "Capy is sending HTML instead of JS to the controller"
    visit root_path
    init_page_headers = page.response_headers
    find_link('New Project').click
    #fill in details and ensure project is created.
  end

  test 'return to projects listing after accessing a use_case' do
    find('table#projects', text: 'Test Project').click_link(@use_case.project.name)
    click_link('Back to Projects')
    current_path.must_equal home_index_path
  end


  # test "the truth" do
  #   assert true
  # end
end

require 'test_helper'
include Warden::Test::Helpers
Warden.test_mode!

class ManageSlicesTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.current_driver = Capybara.javascript_driver
    js_sign_in

    @project = Project.first
    @use_case = @project.use_cases.first
    @steps = @use_case.steps
    @slice = Slice.new(project: @project)

    @use_case.steps.map {|step| @slice.steps << step}
    @slice.save

    find('table#projects', text: @project.name).click_link(@project.name)
    find('table#project_use_cases').click_link(@use_case.name)
    find('#right-yield dd', text: 'Slices').click
  end

  def teardown
    Capybara.current_driver = nil
    super
  end

  test "view slices in a use case" do

    @slice_first = @use_case.slices.first
    select @use_case.slices.first.id, from: 'Slice Selection'
    wait_for_ajax
    save_and_open_page()
    within(:css, "#slice-inner") do
        @slice_first.steps.each do |st|
            page.must_have_content(st.full_desc)
        end
    end
  end

  test 'populate slices' do
    find('.uc-slice a.slice-add').trigger('click')
    wait_for_ajax
    uc_step = @use_case.steps.order('custom_id ASC').first
    page.find('#standard_flows td', text: uc_step.description).drag_to(page.find('#slice-panel tr'))
    slice_count = Slice.count
    page.find('.btn.slice-save').click
    wait_for_ajax
    #slice_count.must_equal (Slice.count + 1)
    # Slice.all.must_include uc_step
  end



end
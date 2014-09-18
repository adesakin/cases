require 'test_helper'

class SlicesControllerTest < ActionController::TestCase
  setup do
    @slice = build(:slice)
    @step = create(:step)
    @slice.steps << @step
    #create(:use_case_with_steps).steps.map {|step| @slice.steps << step}
    @slice.save
    @user = create(:user, password: "secretkey", email: "sample@test.cases.com")
    sign_in @user
  end

  test "should respond to option" do
    skip "Suspended as it is no longer needed - Keep temporarily"
    post :option, :format => 'js', project_id: @slice.project.id
    assert_response :success
  end

  test "should get index" do
    get :index, project_id: @slice.project.id
    assert_response :success
    assert_not_nil assigns(:slices)
  end

  test "should get new" do
    skip "To be refecatored into a nested attribute form"
  end

  test "should create slice" do
    skip 'Fix single inheritance error arising from the associations'
    new_step = create(:step, use_case: @step.use_case)
    assert_difference('Slice.count') do
      post :create, format: :js, project_id: @slice.project, slice: { estimate: @slice.estimate, order_priority: @slice.order_priority, \
        priority: @slice.priority, release_id: @slice.release_id, workflow_state: @slice.workflow_state, flows_attributes: {step_id: new_step.id} }
    end

    assert_redirected_to project_slice_path(@slice.project, assigns(:slice))
  end

  test "should show slice" do
    skip "Redirect to Use Case Path"
    get :show, project_id: @slice.project, id: @slice
    assert_redirected_to project_use_case_path(@slice.project, )
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slice, project_id: @slice.project
    assert_response :success
  end

  test "should update slice" do
    skip 'Fix single inheritance error arising from the associations'
    patch :update, :project_id => @slice.project.id, id: @slice, slice: { estimate: @slice.estimate, order_priority: @slice.order_priority, priority: @slice.priority, release_id: @slice.release_id, workflow_state: @slice.workflow_state }
    assert_redirected_to project_slice_path(@slice.project, assigns(:slice))
  end

  test "should destroy slice" do
    assert_difference('Slice.count', -1) do
      delete :destroy, :project_id => @slice.project, id: @slice
    end

    assert_redirected_to project_slices_path
  end
end

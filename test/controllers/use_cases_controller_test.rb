require 'test_helper'

class UseCasesControllerTest < ActionController::TestCase
  setup do
    @use_case = create(:use_case)
    @user = create(:user, password: "secretkey", email: "sample@test.cases.com")
    sign_in @user
  end

  test "should get index" do
    get :index, :project_id => @use_case.project.id
    assert_response :success
    assert_not_nil assigns(:use_cases)
  end

  test "should get new" do
    skip "To be refecatored into a nested attribute form"
  end

  test "should create use_case" do
    assert_difference('UseCase.count') do
      post :create, project_id: @use_case.project, use_case: { alternate_flow: @use_case.alternate_flow, description: @use_case.description, name: @use_case.name, open_issue: @use_case.open_issue, post_condition: @use_case.post_condition, pre_condition: @use_case.pre_condition, standard_flow: @use_case.standard_flow, state: @use_case.state, project_id: @use_case.project_id }
    end

    assert_redirected_to project_use_case_path(@use_case.project, assigns(:use_case))
  end

  test "should show use_case" do
    get :show, project_id: @use_case.project, id: @use_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, project_id: @use_case.project, id: @use_case
    assert_response :success
  end

  test "should update use_case" do
    patch :update, :project_id => @use_case.project.id, id: @use_case, use_case: { alternate_flow: @use_case.alternate_flow, description: @use_case.description, name: @use_case.name, open_issue: @use_case.open_issue, post_condition: @use_case.post_condition, pre_condition: @use_case.pre_condition, standard_flow: @use_case.standard_flow, state: @use_case.state }
    assert_redirected_to project_use_case_path(@use_case.project, assigns(:use_case))
  end

  test "should destroy use_case" do
    assert_difference('UseCase.count', -1) do
      delete :destroy, :project_id => @use_case.project, id: @use_case
    end

    assert_redirected_to project_use_cases_path
  end
end

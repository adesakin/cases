require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = create(:member)
    @user = create(:user, password: "secretkey", email: "sample@test.cases.com")
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member" do
    @member_new = build(:member_new)
    #@member_new = @user_new.build_member(first_name: "FN_NEW", last_name: "SN_NEW")
    assert_difference('Member.count') do
      post :create, user: {email: @member_new.user.email, password: @member_new.user.password, member_attributes: {first_name: @member_new.first_name, last_name: @member_new.last_name, note: @member_new.note, title: @member_new.title}}, format: :js
    end

    #assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, id: @member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should update member" do
    patch :update, id: @member.user, user: { member_attributes: { first_name: @member.first_name, last_name: @member.last_name, note: @member.note, title: @member.title, id: @member.id }}
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    @member.save
    assert_difference('Member.count', -1) do
      delete :destroy, id: @member
    end

    assert_redirected_to members_path
  end
end

require 'test_helper'

class RevealControllerTest < ActionController::TestCase
  def setup
    user_sign_in()
  end

  test "should get piece" do
    get :piece
    assert_response :success
  end

end

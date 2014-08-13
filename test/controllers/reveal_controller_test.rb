require 'test_helper'

class RevealControllerTest < ActionController::TestCase
  test "should get piece" do
    get :piece
    assert_response :success
  end

end

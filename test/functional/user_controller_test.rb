require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get gamelist" do
    get :gamelist
    assert_response :success
  end

end

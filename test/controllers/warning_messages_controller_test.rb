require 'test_helper'

class WarningMessagesControllerTest < ActionController::TestCase
  test "should get hide_message" do
    get :hide_message
    assert_response :success
  end

end

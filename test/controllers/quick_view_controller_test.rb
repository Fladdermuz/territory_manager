require 'test_helper'

class QuickViewControllerTest < ActionDispatch::IntegrationTest
  test "should get view_terr" do
    get quick_view_view_terr_url
    assert_response :success
  end

end

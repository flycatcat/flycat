require "test_helper"

class PunchcardSettingControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get punchcard_setting_edit_url
    assert_response :success
  end
end

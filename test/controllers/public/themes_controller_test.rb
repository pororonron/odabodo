require "test_helper"

class Public::ThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_themes_new_url
    assert_response :success
  end

  test "should get index" do
    get public_themes_index_url
    assert_response :success
  end

  test "should get show" do
    get public_themes_show_url
    assert_response :success
  end

  test "should get confirm" do
    get public_themes_confirm_url
    assert_response :success
  end
end

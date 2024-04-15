require "test_helper"

class Public::ThemeTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_theme_tags_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_theme_tags_edit_url
    assert_response :success
  end
end

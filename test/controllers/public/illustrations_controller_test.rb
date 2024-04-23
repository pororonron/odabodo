require "test_helper"

class Public::IllustrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_illustrations_new_url
    assert_response :success
  end

  test "should get show" do
    get public_illustrations_show_url
    assert_response :success
  end

  test "should get index" do
    get public_illustrations_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_illustrations_edit_url
    assert_response :success
  end
end

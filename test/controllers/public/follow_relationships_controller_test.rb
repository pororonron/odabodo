require "test_helper"

class Public::FollowRelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get public_follow_relationships_followings_url
    assert_response :success
  end

  test "should get followers" do
    get public_follow_relationships_followers_url
    assert_response :success
  end
end

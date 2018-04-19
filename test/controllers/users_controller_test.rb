require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get update' do
    get users_update_url
    assert_response :success
  end

  test 'should get mypage' do
    get users_mypage_url
    assert_response :success
  end
end

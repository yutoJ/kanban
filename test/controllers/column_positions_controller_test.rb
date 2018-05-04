require 'test_helper'

class ColumnPositionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get update' do
    get column_positions_update_url
    assert_response :success
  end
end

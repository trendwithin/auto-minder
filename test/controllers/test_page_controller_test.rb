require 'test_helper'

class TestPageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get test_page_index_url
    assert_response :success
  end

end

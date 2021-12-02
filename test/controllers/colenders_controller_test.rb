require 'test_helper'

class ColendersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get colenders_index_url
    assert_response :success
  end

end

require 'test_helper'

class TestGeoTagVehiclesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'GET index responds with :success' do
    sign_in users(:vic)
    get geo_tag_vehicles_url
    assert_response :success
  end

  test 'GET index responds with :redirect' do
    get geo_tag_vehicles_url
    assert_response :redirect
  end

  test 'VehicleSearch#new lacking record' do
    sign_in users(:vic)
    options = "NOTHERE"
    get geo_tag_vehicles_url, params: { keywords: options }
    assert_response :success
    assert_equal 'No Match Found', flash[:alert]
  end

  test 'VehicleSearch#new matching record' do
    sign_in users(:vic)
    options = 'xyz'
    get geo_tag_vehicles_url, params: { keywords: options }
    assert_response :success
    assert_equal 'Potential Matches', flash[:success]
  end
end

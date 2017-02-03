require 'test_helper'

class TagMyVehiclesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'TagMyVehicle#create' do
    sign_in users(:vic)
    options = { latitude: 45, longitude: -122 }
    post tag_my_vehicles_url, params: { tag_my_vehicle: options }
    assert_response :success
    assert_equal 'Successfully Tagged.', flash[:notice]
  end

  test 'TagMyVehicle#create Error' do
    sign_in users(:vic)
    options = { latitude: 45 }
    assert_raises(ActiveRecord::StatementInvalid) { post tag_my_vehicles_url, params: { tag_my_vehicle: options } }
  end

  test 'Non-Logged Vehicle#create Failure' do
    options = { latiduted: 45, longitude: -122 }
    post tag_my_vehicles_url, params: { tag_my_vehicle: options }
    assert_response :redirect
  end
end

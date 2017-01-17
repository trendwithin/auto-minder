require "test_helper"

feature "User Accepts Geolocation" do
  scenario "Google Map Generates User Location", :js => true do
    count = GeoTagVehicle.count
    assert_equal 0, count
    visit new_geo_tag_vehicle_path
    page.must_have_content "TAG VEHICLE"
    page.has_css?('div#map')
    page.wont_have_css('div#loader')
    fill_in 'make', with: 'Toyota'
    fill_in 'model', with: 'Celica'
    fill_in 'color', with: 'Black'
    fill_in 'license_plate', with: 'ABCXYZ'
    fill_in 'additional_info', with: 'The Test of Success'
    click_button 'Submit Info'

    visit new_geo_tag_vehicle_path
    assert_equal 1, GeoTagVehicle.count
    vehicle = GeoTagVehicle.last
    assert_equal 'Toyota', vehicle.make
    assert_equal 'Celica', vehicle.model
    assert_equal 'Black', vehicle.color
    assert_equal 'ABCXYZ', vehicle.license_plate
    assert_equal 'The Test of Success', vehicle.additional_info
    assert_equal "40.714224", vehicle.latitude
    assert_equal "-73.961452", vehicle.longitude
  end
end

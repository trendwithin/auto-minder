require "test_helper"

feature "User Geolocation for Vehicle" do
  scenario "User Tags Their Current Location", :js => true do
    user_sign_in users(:vic)
    visit new_tag_my_vehicle_path
    page.has_css?('div#loader')
    page.must_have_content "TAG MY VEHICLE"
    page.has_css?('div#map')
    page.wont_have_css('div#loader')
    page.must_have_content 'Tag Vehicle'
    click_button 'Tag Vehicle'
    page.must_have_content 'SHOW PAGE'
    vehicle = TagMyVehicle.last
    assert_equal "40.714224", vehicle.latitude
    assert_equal "-73.961452", vehicle.longitude
  end
end

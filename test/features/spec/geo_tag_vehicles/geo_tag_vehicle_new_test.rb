require "test_helper"

feature "User Accepts Geolocation" do
  scenario "Google Map Generates User Location", :js => true do
    user_sign_in users(:vic)
    visit new_geo_tag_vehicle_path
    page.must_have_content "TAG VEHICLE"
    page.has_css?('div#map')
    page.wont_have_css('div#loader')
    fill_in 'make', with: 'Toyota'
    fill_in 'model', with: 'Celica'
    fill_in 'color', with: 'Black'
    fill_in 'license_plate', with: 'ABCXYZ'
    fill_in 'state', with: 'WA'
    fill_in 'additional_info', with: 'The Test of Success'
    page.must_have_content 'Submit Info'
    click_button 'Submit Info'

    page.must_have_content 'Successfully Tagged.'
    visit new_geo_tag_vehicle_path
    vehicle = GeoTagVehicle.last
    assert_equal 'Toyota', vehicle.make
    assert_equal 'Celica', vehicle.model
    assert_equal 'Black', vehicle.color
    assert_equal 'ABCXYZ', vehicle.license_plate
    assert_equal 'WA', vehicle.state
    assert_equal 'The Test of Success', vehicle.additional_info
    assert_equal "40.714224", vehicle.latitude
    assert_equal "-73.961452", vehicle.longitude
  end
end

feature 'Submit Info Button Is Not Viewable When Required Fields Have Invalid Data' do
  scenario 'Make Field is Empty', :js => true do
    user_sign_in users(:vic)
    visit new_geo_tag_vehicle_path
    fill_in 'license_plate', with: 'ABCDEFG'
    fill_in 'state', with: 'WA'
    page.wont_have_content 'Submit Info'
    fill_in 'make', with: 'Toyota'
    page.must_have_content 'Submit Info'
  end

  scenario 'License Field is Empty', :js => true do
    user_sign_in users(:vic)
    visit new_geo_tag_vehicle_path
    fill_in 'make', with: 'Toyota'
    fill_in 'state', with: 'WA'
    page.wont_have_content 'Submit Info'
    fill_in 'license_plate', with: 'XYZ'
    page.must_have_content 'Submit Info'
  end

  scenario 'State Field is Emtpy', :js => true do
    user_sign_in users(:vic)
    visit new_geo_tag_vehicle_path
    fill_in 'make', with: 'Toyota'
    fill_in 'license_plate', with: 'XYZ'
    page.wont_have_content 'Submit Info'
    fill_in 'state', with: 'WA'
    page.must_have_content 'Submit Info'
  end

  scenario 'License Field Greater Than 8 Characters', :js => true do
    user_sign_in users(:vic)
    visit new_geo_tag_vehicle_path
    fill_in 'make', with: 'Toyota'
    fill_in 'state', with:'WA'
    fill_in 'license_plate', with: '12345678'
    page.wont_have_content 'Submit Info'
  end
end

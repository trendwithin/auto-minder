require "test_helper"

feature "User Accepts Geolocation" do
  scenario "Google Map Generates User Location", :js => true do
    visit new_geo_tag_vehicle_path
    page.must_have_content "TAG VEHICLE"
    page.has_css?('div#map')
    page.wont_have_css('div#loader')
  end
end

require 'test_helper'

class GeoTagVehicleTest < ActiveSupport::TestCase
  before do
    @vehicle = geo_tag_vehicles(:toyota)
  end

  test 'valid?' do
    assert_equal true, @vehicle.valid?
  end

  test 'invalid without license' do
    @vehicle.license_plate = nil
    refute_equal true, @vehicle.valid?
  end

  test 'license_plate maximum 7' do
    @vehicle.license_plate = '12345678'
    refute_equal true, @vehicle.valid?
  end

  test 'invalid without latitude' do
    @vehicle.latitude = nil
    refute_equal true, @vehicle.valid?
  end

  test 'invalid without longitude' do
    @vehicle.longitude = nil
    refute_equal true, @vehicle.valid?
  end

  test 'requires state' do
    @vehicle.state = nil
    refute_equal true, @vehicle.valid?
  end
end

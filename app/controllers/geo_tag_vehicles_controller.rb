class GeoTagVehiclesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def create
    @vehicle = current_user.geo_tag_vehicles.build(geo_tag_vehicle_params)
    if @vehicle.save
      # something
    end
  end

  private
    def geo_tag_vehicle_params
      params.require(:geo_tag_vehicle).permit(:make, :model, :color, :license_plate, :additional_info, :latitude, :longitude, :state)
    end
end

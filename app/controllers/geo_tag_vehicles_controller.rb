class GeoTagVehiclesController < ApplicationController
  def index
  end

  def new
  end

  def create
    @vehicle = GeoTagVehicle.new(geo_tag_vehicle_params)
    if @vehicle.save
      # something
    end
  end

  private
    def geo_tag_vehicle_params
      params.require(:geo_tag_vehicle).permit(:make, :model, :color, :license_plate, :additional_info, :latitude, :longitude)
    end
end

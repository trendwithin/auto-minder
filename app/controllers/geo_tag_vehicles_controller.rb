class GeoTagVehiclesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def show
  end

  def create
    @vehicle = current_user.geo_tag_vehicles.build(geo_tag_vehicle_params)
    if @vehicle.save
      flash[:notice] = 'Successfully Tagged.'
      flash.keep(:notice)
    else
      respond_to do |format|
        format.html { render :new, notices: 'Sorry. Something went wrong.'}
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def geo_tag_vehicle_params
      params.require(:geo_tag_vehicle).permit(:make, :model, :color, :license_plate, :additional_info, :latitude, :longitude, :state)
    end
end

class TagMyVehiclesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def show
  end

  def create
    @vehicle = current_user.tag_my_vehicles.build(tag_my_vehicle_params)
    if @vehicle.save
      flash[:notice] = 'Successfully Tagged.'
      flash.keep(:notice)
    else
      respond_to do |format|
        format.html { render :new, notices: 'Sorry.  Something went wrong.' }
        format.json { render json: @vechicle.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def tag_my_vehicle_params
      params.require(:tag_my_vehicle).permit(:latitude, :longitude);
    end
end

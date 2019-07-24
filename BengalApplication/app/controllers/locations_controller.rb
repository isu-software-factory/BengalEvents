class LocationsController < ApplicationController
  def index
    @location = Location.all
  end

  def new
    @occasion = Occasion.find_by(params[:occasion_id])
    @location = Location.new
  end

  def create
    @occasion = Occasion.find_by(params[:id])
    @location = Location.create(location_params)
    @location.save
    redirect_to @occasion
  end

  def show
    @occasion = Occasion.find_by(params[:id])
    @location = Location.find_by(params[:id])
  end


  private

  def location_params
    params.require(:location).permit(:start_time, :end_time)
  end
end

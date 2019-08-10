class LocationsController < ApplicationController

  def index
    @location = Location.all
  end

  def new
    @occasion = Occasion.find(params[:occasion_id])
    @location = @occasion.locations.build
    authorize @location
  end

  def create
    @occasion = Occasion.find(params[:occasion_id])
    @location = @occasion.locations.build(location_params)
    authorize @location
    if @location.save
      redirect_to occasion_path(@occasion), :notice => "Successfully created Location."
    else
      flash[:errors] = @location.errors.full_messages
      redirect_back(fallback_location: new_occasion_location_path)
    end
  end

  def edit
    @occasion = Occasion.find(params[:occasion_id])
    @location = Location.find(params[:id])
  end

  def update
    @occasion = Occasion.find(params[:occasion_id])
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to occasion_path(@occasion), :notice => "Successfully updated Occasion."
    else
      flash[:errors] = @event.errors.full_messages
      redirect_back(fallback_location: edit_occasion_event_path)
    end
  end

  def show
    @occasion = Occasion.find_by(params[:occasion_id])
    @location = Location.find_by(params[:id])
    authorize @location
  end

  def destroy
    @occasion = Occasion.find(params[:occasion_id])
    location = Location.find(params[:id])
    authorize location
    location.destroy
    redirect_to occasion_path(@occasion)
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end

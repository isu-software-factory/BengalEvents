class LocationsController < ApplicationController
  before_action :authenticate_user!

  def manage
    @locations = Location.all
    add_home_breadcrumb
    add_breadcrumb "Manage Locations", manage_locations_path
  end

  def destroy
    @location = Location.find(params[:id])
    authorize @location
    if @location.destroy
      redirect_to manage_locations_path, notice: 'Successfully Deleted Location.'
    else
      flash[:error] = 'We were unable to destroy the location.'
    end
  end

  def destroy_room
    @room = Room.find(params[:id])
    authorize @room, policy_class: LocationPolicy
    if @room.destroy
      redirect_to manage_locations_path, notice: "Successfully Deleted Room."
    else
      flash[:error] = "We were unable to destroy the room."
    end
  end


  # def index
  #   @location = Location.all
  # end
  #
  # def new
  #   @occasion = Occasion.find(params[:occasion_id])
  #   @location = @occasion.locations.build
  #   @time_slot = @location.time_slots.build
  #   authorize @location
  #
  #   add_breadcrumb "Home", current_user.meta
  #   add_breadcrumb "#{@occasion.name}", @occasion
  #   add_breadcrumb "New Location", new_occasion_location_path(@occasion)
  # end
  #
  # def create
  #   @occasion = Occasion.find(params[:occasion_id])
  #   @location = @occasion.locations.build(location_params)
  #   # pry
  #   authorize @location
  #   if @location.save
  #     redirect_to event_path(@occasion), notice: 'Successfully created Location.'
  #   else
  #     flash[:errors] = @location.errors.full_messages
  #     redirect_back(fallback_location: new_occasion_location_path)
  #   end
  # end
  #
  # def edit
  #   @occasion = Occasion.find(params[:occasion_id])
  #   @location = Location.find(params[:id])
  # end
  #
  # def update
  #   @occasion = Occasion.find(params[:occasion_id])
  #   @location = Location.find(params[:id])
  #   if @location.update(location_params)
  #     redirect_to event_path(@occasion), notice: 'Successfully updated Location.'
  #   else
  #     flash[:errors] = @location.errors.full_messages
  #     redirect_back(fallback_location: edit_occasion_activity_path)
  #   end
  # end
  #
  # def show
  #   @occasion = Occasion.find(params[:occasion_id])
  #   @location = Location.find(params[:id])
  #   authorize @location
  # end
  #
  # def destroy
  #   @occasion = Occasion.find(params[:occasion_id])
  #   location = Location.find(params[:id])
  #   authorize location
  #   location.destroy
  #   redirect_to event_path(@occasion), notice: 'Successfully deleted Location.'
  # end

  private

end

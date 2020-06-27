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

  def new
    @location = Location.new
    @action = "locations/create"
    @remote = true
  end

  def create
    @location = Location.new(location_name: params['location'], address: params['address'])
    respond_to do |format|
      if @location.save
        format.js
        format.html { redirect_to manage_locations_path, notice: "Successfully Created New Location." }
      else
        flash[:error] = @location.errors.full_message
        redirect_to manage_location_path
      end
    end
  end

  def edit
    @location = Location.find(params[:id])
    @action = "locations/update"
    @remote = true
  end

  def update
    @location = Location.find(params[:location_id])
    respond_to do |format|
      if @location.update(location_name: params['location'], address: params['address'])
        format.html { redirect_to manage_locations_path }
      else
        format.html {
          flash[:error] = @location.errors.full_message
          redirect_to manage_location_path
        }
      end
      end
    end

  end

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
      flash[:errors] = 'We were unable to destroy the location.'
      redirect_back(fallback_location: manage_locations_path)
    end
  end

  def destroy_room
    @room = Room.find(params[:id])
    authorize @room, policy_class: LocationPolicy
    if @room.destroy
      redirect_to manage_locations_path, notice: "Successfully Deleted Room."
    else
      flash[:errors] = "We were unable to destroy the room."
      redirect_back(fallback_location: manage_locations_path)
    end
  end

  def new
    @location = Location.new
    @action = "locations/create"
    @remote = true
  end

  def create
    @location = Location.new(location_name: params['location'], address: params['address'])
    if @location.save
      redirect_to manage_locations_path, notice: "Successfully Created New Location."
    else
      flash[:errors] = @location.errors.full_messages
      redirect_back(fallback_location: manage_locations_path)
    end

  end

  def edit
    @location = Location.find(params[:id])
    @action = "locations/update"
    @remote = true
  end

  def update
    @location = Location.find(params[:location_id])
    if @location.update(location_name: params['location'], address: params['address'])
      results = update_rooms(@location)
      if results[0]
        redirect_to manage_locations_path
      else
        flash[:errors] = results[1]
        redirect_back(fallback_location: manage_locations_path)
      end
    else
      flash[:errors] = @location.errors.full_messages
      redirect_back(fallback_location: manage_locations_path)
    end
  end

  def new_room
    @location = Location.find(params[:id])
    @action = "locations/create/room"
  end

  def create_room
    @location = Location.find(params[:location_id])
    room = Room.new(room_number: params[:room_number], room_name: params[:room_name], location_id: @location.id)
    if room.save
      redirect_to manage_locations_path
    else
      flash[:errors] = room.errors.full_messages
      redirect_back(fallback_location: manage_locations_path)
    end
  end


  private

  def get_id(name)
    ids = []
    params.each do |key, value|
      if key.start_with?(name)
        ids << key.split("_")[2].to_i
      end
    end
    ids
  end

  def update_rooms(location)
    ids = get_id("room_name")
    results = []
    errors = []
    no_error = true
    ids.each do |i|
      room = location.rooms.find_by(id: i)
      unless room.update(room_name: params["room_name_" + i.to_s], room_number: params["room_number_" + i.to_s])
        errors += room.errors.full_messages
        no_error = false
      end
    end
    results << no_error
    results << errors
    results
  end

end

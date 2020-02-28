class EventsController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized, except: %i[index destroy create show new edit]

  def index
    @events = Event.all
    @activities = Event.first.activities
    @role = ""
    if params[:role] == "Team"
      @role = "Team"
      @user = Team.find(params[:id])
    else
      @role = "User"
      @user = User.find(params[:id])
    end
    add_breadcrumb "Home", root_path(role: @role, id: @user.id)
  end

  def new
    @event = Event.new
    2.times {@event.activities.build.sessions.build}
    authorize @event
    add_breadcrumb 'Home', root_path
    add_breadcrumb 'New Event', new_event_path
  end

  def create
    @event = Event.new(event_params)
    authorize @event
    # create locations and rooms
    create_locations

    if @event.save
      redirect_to root_path(role: "User", id: current_user.id)
    else
      flash[:errors] = @event.errors.full_messages
      redirect_back(fallback_location: new_event_path)
    end
  end

  def show
    @location = Location.all
    @event = Event.find(params[:id])
    authorize @event
    add_breadcrumb 'Home', root_path
    add_breadcrumb @event.name, event_path(@event)
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
    add_breadcrumb "Home", root_path
    add_breadcrumb @event.name, event_path
    # add_breadcrumb "Edit", edit_event_path(@event)
  end

  def update
    @event = Event.find(params[:id])
    authorize @event
    if @event.update(event_params)
      redirect_to events_path, :notice => 'Successfully updated Occasion.'
    else
      flash[:errors] = @events.errors.full_messages
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    authorize event
    if event.destroy
      redirect_to events_path, notice: 'Successfully Deleted Occasion.'
    else
      flash[:error] = 'We were unable to destroy the Occasion.'
    end
  end

  private

  def event_params
    params.permit(:name, :start_date, :description)
  end

  # get locations from parameters
  def get_values(name)
    values = []
    # add locations to locatinos array
    params.each do |key, value|
      if key.start_with?(name)
        values << value
      end
    end
    values
  end

  def create_locations
    locations = get_values("location")
    addresses = get_values("address")
    new_locations = []
    count = 0

    # create locations
    locations.each do |location|
      new_locations << Location.create(location_name: location, address: addresses[count])
      count += 1
    end

    add_rooms(new_locations)
  end

  def add_rooms(locations)
    room_numbers = get_values("room_number")
    room_names = get_values("room_name")
    count = 0
    location_count = -1
    # create rooms and add them to locations
    room_numbers.each do |room|
      if room.start_with?("room_number_New")
        location_count += 1
        locations[location_count].rooms.create(room_number: room, room_name: room_names[count])
      else
        locations[location_count].rooms.create(room_number: room, room_name: room_names[count])
      end
      count += 1
    end
  end

end


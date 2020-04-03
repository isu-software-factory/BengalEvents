class EventsController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized, except: %i[index destroy create show new edit]

  def index
    @events = Event.all
    @role = ""
    add_breadcrumb "Home", root_path(role: "User", id: current_user.id)
    if params[:role] == "Team"
      @role = "Team"
      @user = Team.find(params[:id])
      add_breadcrumb current_user.first_name + "'s Profile", profile_path(current_user)
      add_breadcrumb "Team", team_path(@user.id)
      add_breadcrumb "Team Registration", root_path(role: @role, id: @user.id)
    else
      @role = "User"
      @user = User.find(params[:id])
      if (current_user.roles.first.role_name == "Teacher" && @user.id != current_user.id)
        add_breadcrumb current_user.first_name + "'s Profile", profile_path(current_user)
        add_breadcrumb "Register For " + @user.first_name, ""
      end
    end
  end

  def new
    @event = Event.new
    @action = "create"
    @edit = false
    @locations = Location.all
    authorize @event
    add_breadcrumb 'Home', root_path
    add_breadcrumb 'New Event', new_event_path
  end

  def create
    @event = Event.new(event_params)
    authorize @event
    # create locations and rooms
    errors = create_locations

    if errors.length <= 0 && @event.save
      redirect_to new_activity_path(event_id: @event.id)
    else
      flash[:errors] = @event.errors.full_messages + errors
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
    @action = "update"
    @locations = Location.all
    @edit = true
    authorize @event
    add_breadcrumb "Home", root_path
    add_breadcrumb @event.name, event_path
    # add_breadcrumb "Edit", edit_event_path(@event)
  end

  def update
    @event = Event.find(params[:id])
    authorize @event
    if @event.update(event_params)
      redirect_to profile_path(current_user), :notice => 'Successfully Updated ' + @event.name
    else
      flash[:errors] = @event.errors.full_messages
      redirect_back(fallback_location: edit_event_path(@event))
    end
  end

  def destroy
    event = Event.find(params[:id])
    authorize event
    if event.destroy
      redirect_to profile_path(current_user), notice: 'Successfully Deleted Event.'
    else
      flash[:error] = 'We were unable to destroy the Event'
    end
  end

  private

  def event_params
    params.permit(:name, :start_date, :description)
  end

  # get locations from parameters
  def get_values(name)
    values = []

    params.each do |key, value|
      if key.start_with?(name)
        values << value
      end
    end
    values
  end

  def get_keys(name)
    keys = []

    params.each do |key, value|
      if key.start_with?(name)
        keys << key
      end
    end
    keys
  end

  # create locations
  def create_locations
    locations = get_values("location")
    addresses = get_values("address")
    new_locations = []
    errors = []
    count = 0

    # create locations
    locations.each do |location|
      local = Location.new(location_name: location, address: addresses[count])
      if local.save
        new_locations << local
      else
        errors += local.errors.full_messages
      end
      count += 1
    end

    # check locations aren't empty
    if new_locations.length == 0
      errors
    else
      errors += add_rooms(new_locations)
      errors
    end
  end

  # create and add rooms to locations
  def add_rooms(locations)
    room_numbers = get_values("room_number")
    room_names = get_values("room_name")
    room_keys = get_keys("room_number")
    count = 0
    location_count = -1
    errors = []

    # create rooms and add them to locations
    room_keys.each do |room|
      if room.start_with?("room_number_New")
        location_count += 1
        errors += create_room(room_numbers[count], room_names[count], locations[location_count].id)
      else
        errors += create_room(room_numbers[count], room_names[count], locations[location_count].id)
      end
      count += 1
    end
    errors
  end

  def create_room(room, r_name, local_id)
    errors = []
    new_room = Room.new(room_number: room, room_name: r_name, location_id: local_id)
    unless new_room.save
      errors += new_room.errors.full_messages
    end
    errors
  end

end


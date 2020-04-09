class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_occasion, only: %i[new create destroy update edit show]
  before_action :set_event, only: %i[show]
 # after_action :verify_authorized

  def new
    @activity = Activity.new
    @sessions = []
    @event = Event.find(params[:event_id])
    authorize @activity
    @action = "create/" + @event.id.to_s
    add_breadcrumb 'Home', profile_path(current_user)
    add_breadcrumb 'Create Activity', new_activity_path
  end

  def create
    @event = Event.find(params[:event_id])
    errors = create_activities(@event)
    if errors.length == 0
      flash[:notice] = "Successfully Created Activity"
      redirect_to profile_path(current_user)
    else
      flash[:errors] = errors
      redirect_back(fallback_location: new_activity_path)
    end
  end


  def edit
    @activity = Activity.find(params[:id])
    @event = @activity.event
    authorize @activity
    @sessions = @activity.sessions
    @edit = true
    @action = "update"
    add_breadcrumb "Home", profile_path(current_user)
    add_breadcrumb "Edit " + @activity.name, activity_path(@activity)
  end


  def report
    @users = User.all
    @teachers = Teacher.all
    @activities = Activity.all
  end

  def update
    # authorize @event
    @activity = Activity.find(params[:id])
    @event = @activity.event

    # delete sessions
    delete_sessions(@activity)

    # update sessions
    update_sessions(@activity)

    if @activity.update(name: params[:name_New_1], description: params[:description_1], iscompetetion: params[:iscompetetion_1], ismakeahead: params[:ismakeahead_1])
      redirect_to profile_path(current_user), notice: 'Successfully Updated Activity.'
    else
      flash[:errors] = @activity.errors.full_messages
      redirect_back(fallback_location: edit_activity_path(@activity))
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    authorize @activity
    if @activity.destroy
      redirect_to profile_path(current_user), notice: 'Successfully Deleted Activity.'
    else
      flash[:error] = 'We were unable to destroy the activity.'
    end
  end

  def get_session_rooms
    activity = Activity.find(params[:activity])
    rooms = []
    activity.sessions.each do |s|
      rooms << s.room
    end
    rooms = rooms
    render json: {results: {rooms: rooms}}
  end

  def get_locations
    locations = Location.all
    render json: {results: {locations: locations}}
  end

  def get_rooms
    rooms = Location.find_by(location_name: params[:location]).rooms
    render json: {results: {rooms: rooms}}
  end
end

private

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

def get_param_with_index(name, index)

  params.each do |key, value|
    if key.start_with?(name) && key.ends_with?(index.to_s)
      return value
    end
  end
end

# get ids from keys with only one underscore
def get_ids(name)
  ids = []
  params.each do |key, value|
    if key.start_with?(name)
      ids << key.split("_")[1].to_i
    end
  end
  ids
end

def update_sessions(activity)
  ids = get_keys("end_time")
  ids.each do |id|
    id = id.split("end_time_")[1].to_i
    if activity.has_session(id.to_i)
      room_num = get_param_with_index("room_select", id).split(" (")[0].to_i
      Session.find(id).update(start_time: get_param_with_index("start_time", id), end_time: get_param_with_index("end_time", id), capacity: get_param_with_index("capacity", id),  room_id: Room.find_by(room_number: room_num).id)
    else
      create_session(get_param_with_index("start_time", id), get_param_with_index("room_select", id), get_param_with_index("capacity", id), activity, get_param_with_index("end_time", id))
    end
  end
end

def delete_sessions(activity)
  ids = get_ids("capacity")
  activity.sessions.each do |s|
    # remove session
    unless ids.include?(s.id)
      s.destroy
    end
  end
end

def create_activities(event)
  activity_names = get_values("name")
  descriptions = get_values("description")
  make_ahead = get_values("ismakeahead")
  competitions = get_values("iscompetetion")
  count = 0
  new_activities = []
  errors = []
  team_sizes = get_values("max_team_tag")
  # create activities
  activity_names.each do |name|
    local = Activity.new(name: name, description: descriptions[count], ismakeahead: make_ahead[count], iscompetetion: competitions[count], user_id: current_user.id, event_id: event.id, max_team_size: competitions[count] == "true" ? team_sizes[count].to_i : 0)
    if local.save
      new_activities << local
    else
      errors += local.errors.full_messages
    end
    count += 1
  end

  # check activities aren't empty
  if new_activities.length == 0
    errors
  else
    errors += add_sessions(new_activities)
    errors
  end
end


def add_sessions(activities)
  start_time = get_values("start_time")
  end_time = get_values("end_time")
  rooms = get_values("room_select")
  capacities = get_values("capacity")
  new_sessions = get_keys("start_time")
  count = 0
  activity_count = -1
  errors = []

  # create rooms and add them to locations
  new_sessions.each do |session|
    if session.start_with?("start_time_New")
      activity_count += 1
      errors += create_session(start_time[count], rooms[count], capacities[count], activities[activity_count], end_time[count])
    else
      errors += create_session(start_time[count], rooms[count], capacities[count], activities[activity_count], end_time[count])
    end
    count += 1
  end
  errors
end

def create_session(start_time, room, capacity, activity, end_time)
  errors = []
  room_num = room.split(" (")[0].to_i
  new_session = Session.new(start_time: start_time, capacity: capacity, activity_id: activity.id, end_time: end_time, room_id: Room.find_by(room_number: room_num).id)
  unless new_session.save
    errors += new_session.errors.full_messages
  end
  errors
end


def set_event
  @event = Event.find(params[:id])
end



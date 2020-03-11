class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_occasion, only: %i[new create destroy update edit show]
  before_action :set_event, only: %i[destroy update edit show]
 # after_action :verify_authorized

  def new
    @activity = Activity.new
    @event = Event.find(params[:event_id])
    authorize @activity
    add_breadcrumb 'Home', root_path
    add_breadcrumb @event.name, @event
    add_breadcrumb 'Create Event', new_activity_path
  end

  def create
    @event = Event.find(params[:event_id])
    errors = create_activities(@event)
    if errors.length == 0
      flash[:notice] = "Successfully Created Activity"
      redirect_to @event
    else
      flash[:errors] = errors
      redirect_back(fallback_location: new_activity_path)
    end
  end


  def edit
    @activity = Activity.find(params[:id])
    authorize @event
    add_breadcrumb "Home", root_path
    add_breadcrumb @event.name, event_path(@event)
    add_breadcrumb @activity.name, activity_path(@activity)
  end

  def show
    authorize @event

    add_breadcrumb "Home", current_user.meta
    add_breadcrumb @occasion.name, @occasion
    add_breadcrumb @event.name, occasion_activities_path(@event)

  end

  def update
    # authorize @event
    @activity = Activity.find(params[:id])
    @event = @activity.event
    if @activity.update(activity_params)
      redirect_to @event, notice: 'Successfully updated Event.'
    else
      flash[:errors] = @activity.errors.full_messages
      redirect_back(fallback_location: edit_activity_path(@activity))
    end
  end

  def destroy
    authorize @event
    if @event.destroy
      redirect_to event_path(@occasion), notice: 'Successfully Deleted Event.'
    else
      flash[:error] = 'We were unable to destroy the event.'
    end
  end

  def location_timeslots
    location = Location.find_by(name: params[:name])
    time_slots = location.time_slots
    return render json: {results: {dates: [], times: []}} if time_slots.empty?

    results = time_slots.each do |time|
      dates = ((location.occasion.start_date.to_date)...(location.occasion.end_date.to_date)).to_a
      start_time = time.start_time
      end_time = time.end_time
      times = [start_time.strftime('%H:%M')]
      begin
        start_time += time.interval.minutes
        times << start_time.strftime('%H:%M')
      end while start_time < end_time
      render json: {results: {dates: dates, times: times}}
    end
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


def create_activities(event)
  activity_names = get_values("name")
  descriptions = get_values("description")
  make_ahead = get_values("ismakeahead")
  competitions = get_values("iscompetetion")
  count = 0
  new_activities = []
  errors = []

  # create activities
  activity_names.each do |name|
    local = Activity.new(name: name, description: descriptions[count], ismakeahead: make_ahead[count], iscompetetion: competitions[count], user_id: current_user.id, event_id: event.id)
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
  new_session = Session.new(start_time: start_time, capacity: capacity, activity_id: activity.id, end_time: end_time)
  unless new_session.save
    errors += new_session.errors.full_messages
  else
    room_num = room.split(" (")[0].to_i
    room_update = Room.find_by(room_number: room_num)
    room_update.update(session_id: new_session.id)
  end

  errors
end


def set_event
  @event = Event.find(params[:id])
end

def activity_params
  params.require(:activity).permit(:name, :description, :ismakeahead, :iscompetetion, user_id: current_user.id)
end

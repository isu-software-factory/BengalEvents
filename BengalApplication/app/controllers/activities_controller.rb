class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show]
  before_action :get_activities, only: [:edit, :new]
  require 'active_support/core_ext/hash'

  def new
    @event = Event.find(params[:event_id])
    @activity = Activity.new
    @sessions = []
    authorize @activity
    # the action passed to the form
    @action = 'create/' + @event.id.to_s
    # breadcrumbs for coordinator/sponsor
    add_home_breadcrumb
    add_breadcrumb 'Create Activity', new_activity_path
  end

  def create
    @event = Event.find(params[:event_id])
    @activity = Activity.new
    authorize @activity
    errors = create_activities(@event)

    # any errors with creating activity or sessions
    if errors.empty?
      flash[:notice] = 'Successfully Created Activity'
      redirect_to profile_path(current_user)
    else
      flash[:errors] = errors
      redirect_back(fallback_location: new_activity_path)
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    authorize @activity
    # set variables
    @event = @activity.event
    @sessions = @activity.sessions
    @edit = true
    @action = 'update'
    # breadcrumb for coordinators/sponsor
    add_home_breadcrumb
    add_breadcrumb 'Edit ' + @activity.name, activity_path(@activity)
  end

  def update
    @activity = Activity.find(params[:id])
    authorize @activity
    @event = @activity.event
    # delete sessions
    delete_sessions(@activity)
    # update sessions
    update_sessions(@activity)
    # update activity
    if @activity.update(name: params[:name_New_1], description: params[:description_1], iscompetetion: params[:iscompetetion_1], ismakeahead: params[:ismakeahead_1])
      redirect_to profile_path(current_user), notice: 'Successfully Updated Activity.'
    else
      # show errors
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

  # overtime report of activities
  def report
    @activities = Activity.all
    authorize @activities
    add_home_breadcrumb
    add_breadcrumb 'Reports', report_path
  end

  # add user to the waitlist of session
  def waitlist
    @session = Session.find(params[:session_id])
    if @session.activity.iscompetetion
      @user = Team.find(params[:id])
      @session.waitlist.teams << @user
      # add user to waitlist
      flash[:notice] = "You're team has been successfully added to the waitlist"
      redirect_back(fallback_location: root_path(role: "Team", id: @user.id))
    else
      @user = User.find(params[:id])
      @session.waitlist.users << @user
      # add user to waitlist
      flash[:notice] = "You have been successfully added to the waitlist"
      redirect_back(fallback_location: root_path(role: "User", id: @user.id))
    end
  end

  # session participant spreadsheet
  def spread_sheet
    @session = Session.find(params[:id])
    # create workbook
    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]
    # add headers
    worksheet.add_cell(0, 0, "Attendance")
    worksheet.add_cell(0, 1, "Participant Name")
    worksheet.add_cell(0, 2, "Score")
    # change column width
    worksheet.change_column_width(0, 15)
    worksheet.change_column_width(1, 20)
    # cell coordinates
    x = 1
    y = 1
    # fill cells with data
    @session.users.each do |u|
      worksheet.add_cell(y, x, u.first_name + " " + u.last_name)
      y += 1
    end
    # download
    send_data(workbook.stream.string,
              disposition: "attachment",
              type: "application/excel",
              filename: @session.activity.name + ".xlsx"
    )
  end

  # download attendance rate spreadsheet
  def attendance_rate
    @activity = Activity.find(params[:id])
    # create workbook
    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]
    # add headers
    worksheet.add_cell(0, 0, "Date")
    worksheet.add_cell(0, 1, "Participants")

    worksheet.change_column_width(0, 15)
    worksheet.change_column_width(1, 20)
    # cell coordinates
    x = 1
    y = 1
    # fill cells with data

    # download
    send_data(workbook.stream.string,
              disposition: "attachment",
              type: "application/excel",
              filename: @session.activity.name + ".xlsx"
    )
  end


  # Ajax methods
  # returns the rooms in activity
  def get_session_rooms
    activity = Activity.find(params[:activity])
    rooms = []
    activity.sessions.each do |s|
      rooms << s.room
    end
    rooms = rooms
    render json: {results: {rooms: rooms}}
  end

  # returns the activities for a given date
  def load_activities
    @event = Event.find_by(start_date: DateTime.parse(params[:date]))

    if @event
      total_part = []
      sponsor = []
      @event.activities.each do |a|
        total_part << a.total_participants
        sponsor << a.user
      end
      render json: {activities: {activity: @event.activities, participants: total_part, sponsors: sponsor}}
    end
  end

  # return all locations
  def get_locations
    locations = Location.all
    render json: {results: {locations: locations}}
  end

  # return the rooms in the location
  def get_rooms
    rooms = Location.find_by(location_name: params[:location]).rooms
    render json: {results: {rooms: rooms}}
  end

  # returns the information of all the activities with the same identifier
  def detailed_report
    activity = Activity.find(params[:id])
    activities = Activity.where(identifier: activity.identifier)
    total_part = []
    sponsor = []
    date = []
    activities.each do |a|
      sponsor << a.user
      total_part << a.total_participants
      date << a.event.start_date.strftime("%d/%m/%Y")
    end
    render json: {activities: {activity: activities, participants: total_part, sponsors: sponsor, dates: date}}
  end
end


private

# return the values in param name
def get_values(name)
  values = []
  params.each do |key, value|
    if key.start_with?(name)
      values << value
    end
  end
  values
end

# return the keys with the given name
def get_keys(name)
  keys = []
  params.each do |key, value|
    if key.start_with?(name)
      keys << key
    end
  end
  keys
end

# return the value with the given name and index
def get_param_with_index(name, index)
  if index == "" || name == "" || index.nil? || name.nil?
    return "empty index or name"
  else
    params.each do |key, value|
      if key.start_with?(name) && key.ends_with?(index.to_s)
        return value
      end
    end
    nil
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

# gets or creates a new identifiers for an activity
def check_identifier(index)
  identifier = get_param_with_index("repeats_", index.to_s)
  if identifier.nil?
    if Activity.last.nil?
      return 1
    end
    return Activity.last.identifier + 1
  else
    return Activity.find_by(name: get_param_with_index("repeat_activity_", index.to_s)).identifier
  end
end

# update sessions
def update_sessions(activity)
  ids = get_keys("end_time")
  ids.each do |id|
    id = id.split("end_time_")[1].to_i
    # checks if activity has a session with the given index
    if activity.has_session(id.to_i)
      room_num = get_param_with_index("room_select_", id)
      if !room_num.nil?
        room_num = room_num.split(" (")[0].to_i
        Session.find(id).update(start_time: get_param_with_index("start_time", id), end_time: get_param_with_index("end_time", id), capacity: get_param_with_index("capacity", id), room_id: Room.find_by(room_number: room_num).id)
      else
        raise "Room Num is Nil! \n id: " + id.to_s + "\n" + "params: " + params.to_s + "\n"
      end
    else
      create_session(get_param_with_index("start_time", id), get_param_with_index("room_select", id), get_param_with_index("capacity", id), activity, get_param_with_index("end_time", id))
    end
  end
end

# deletes a session
def delete_sessions(activity)
  ids = get_ids("capacity")
  activity.sessions.each do |s|
    # remove session
    unless ids.include?(s.id)
      s.destroy
    end
  end
end

# creates activities given by parameters
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
    local = Activity.new(name: name, description: descriptions[count], ismakeahead: make_ahead[count], iscompetetion: competitions[count], user_id: current_user.id, event_id: event.id, max_team_size: competitions[count] == "true" ? team_sizes[count].to_i : 0, identifier: check_identifier(count + 1))
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
  if new_session.save
    new_session.waitlist = Waitlist.create()
  else
    errors += new_session.errors.full_messages
  end
  errors
end

def get_activities
  activities = Activity.all
  @activities = []
  @identifiers = []
  activities.each do |a|
    unless @identifiers.include?(a.identifier)
      @activities << a
      @identifiers << a.identifier
    end
  end
  @activities
end

def set_event
  @event = Event.find(params[:id])
end



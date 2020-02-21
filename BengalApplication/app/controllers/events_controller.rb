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
    if @event.save
      redirect_to events_path
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
    params.require(:event).permit(:start_date, :description, :name,
                                  activities_attributes: [:id, :name, :description, :user_id,
                                                          :_destroy, sessions_attributes:[ :id, :start_time, :end_time, :capacity]])
  end
end


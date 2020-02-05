class EventsController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized, except: %i[index destroy create show new edit]

  def index
    @events = Event.all
    add_breadcrumb "Home", current_user
    add_breadcrumb "Occasion List", events_path
  end

  def new
    @event = Event.new
    1.times {@event.activities.build}
    # authorize @occasion
    add_breadcrumb 'Home', current_user
    add_breadcrumb 'New Occasion', new_event_path
  end

  def create
    @event = Event.new(event_params)
    # authorize occasion
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
    # authorize @occasion
    add_breadcrumb 'Home', current_user
    add_breadcrumb @event.name, event_path(@event)
  end

  def edit
    @event = Event.find(params[:id])
    # authorize @occasion
    add_breadcrumb "Home", current_user
    add_breadcrumb @event.name, event_path
    # add_breadcrumb "Edit", edit_event_path(@event)
  end

  def update
    @event = Event.find(params[:id])
    # authorize @occasion
    if @event.update(event_params)
      redirect_to events_path, :notice => 'Successfully updated Occasion.'
    else
      flash[:errors] = @events.errors.full_messages
       render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    # authorize occasion
    if event.destroy
      redirect_to events_path, notice: 'Successfully Deleted Occasion.'
    else
      flash[:error] = 'We were unable to destroy the Occasion.'
    end
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :description, :name,
                                  activities_attributes: [:id, :name, :description, :user_id, :_destroy])
  end
end


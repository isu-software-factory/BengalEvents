class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_occasion, only: [:new, :create, :delete, :update, :edit, :show]
  before_action :set_event, only: [:delete, :update, :edit, :show]
  # after_action :verify_authorized

  def new
    @event = current_user.meta.events.build
    authorize @event
  end

  def create
    @event = current_user.meta.events.build(event_params)
    @event.occasion = @occasion
    # binding.pry
    authorize @event
    if @event.save
      redirect_to occasion_path(@occasion)
    else
      flash[:errors] = @event.errors.full_messages
      redirect_back(fallback_location: new_occasion_event_path)
    end
  end

  def edit
    authorize @event
  end

  def show
    authorize @event
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to occasion_path(@occasion)
    else
      flash[:errors] = @event.errors.full_messages
      redirect_back(fallback_location: edit_occasion_event_path)
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to occasion_path(@occasion)
  end

  def location_timeslots
    location = Location.find_by(name: params[:name])
    time_slots = location.time_slots
    results = time_slots.each do |time|
      # binding.pry
      start_time = time.start_time
      end_time = time.end_time
      times = [start_time.strftime('%H:%M')]
      begin
        start_time += time.interval.minutes
        times << start_time.strftime('%H:%M')
      end while start_time < end_time
      render json: times.to_json
    end
  end
end


private

def set_event
  @event = Event.find(params[:id])
end

def set_occasion
  @occasion = Occasion.find(params[:occasion_id])
end

def event_params
  params.require(:event).permit(:name, :description, :isMakeAhead)
end



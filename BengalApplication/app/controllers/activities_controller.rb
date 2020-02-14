class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_occasion, only: %i[new create destroy update edit show]
  # before_action :set_event, only: %i[destroy update edit show]
  # after_action :verify_authorized

  def new
    @activity = Activity.new
    4.times {@activity.sessions.build}


    # @event = Event.find(params[:event_id])
    # authorize @event
    add_breadcrumb 'Home', current_user
    # add_breadcrumb @event.name, @event
    # add_breadcrumb 'Create Event', new_occasion_activity_path(@occasion)
  end

  def create
    @event = Event.find(params[:activity][:event_id])
    @activity = @event.activities.build(activity_params)
    if @activity.save
      redirect_to @event
    else
      flash[:errors] = @activity.errors.full_messages
      redirect_back(fallback_location: new_activity_path)
    end
  end

  # def create
  #   @event = current_user.meta.supervisor.events.build(event_params)
  #   @event.occasion = @occasion
  #   authorize @event
  #   if @event.save
  #     redirect_to new_occasion_event_event_detail_path(@occasion, @event), notice: 'Successfully created Event.'
  #   else
  #     flash[:errors] = @event.errors.full_messages
  #     redirect_back(fallback_location: new_occasion_activity_path)
  #   end
  # end

  def edit
    @activity = Activity.find(params[:id])
    # authorize @event
    add_breadcrumb "Home", current_user
    # add_breadcrumb @occasion.name, event_path(@occasion)
    # add_breadcrumb @event.name, occasion_activity_path(@occasion, @event)
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
end

private

#
# def set_event
#   @event = Event.find(params[:id])
# end
#
# def set_event
#   @event = Event.find(params[:event_id])
# end

def activity_params
  params.require(:activity).permit(:name, :description, :ismakeahead, :iscompetetion, user_id: current_user.id)
end

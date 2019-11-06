class EventDetailsController < ApplicationController
  before_action :set_event
  before_action :set_event_detail, except: %i[new create]
  before_action :set_occasion

  def new
    @event_detail = EventDetail.new
    @occasion = Occasion.find(params[:occasion_id])
    @event = Event.find(params[:event_id])
    authorize @event_detail

    add_breadcrumb "Home", current_user.meta
    add_breadcrumb @occasion.name, @occasion
    add_breadcrumb @event.name, occasion_events_path(@event)
    add_breadcrumb "New Time Slot", new_occasion_event_event_detail_path(@occasion, @event)
  end

  def create
    @event_details = @event.event_details.new(event_detail_params)
    @event_details.start_time = @event_details.date_started.to_s + ' ' + @event_details.start_time.strftime('%H:%M')
    @event_details.end_time = @event_details.date_started.to_s + ' ' + @event_details.end_time.strftime('%H:%M')
    authorize @event_details

    if @event_details.save
      # add a waitlist to event
      @waitlist = Waitlist.new
      @waitlist.event_detail = @event_details
      @waitlist.save
      # binding.pry
      redirect_to occasion_event_path(@occasion, @event), notice: 'Successfully created Event Session.'
    else
      flash[:errors] = @event_details.errors.full_messages
      redirect_back(fallback_location: new_occasion_event_event_detail_path(@occasion, @event))
    end
  end

  def edit
    authorize @event_detail
    add_breadcrumb "Home", current_user.meta
    add_breadcrumb @occasion.name, occasion_path(@occasion)
    add_breadcrumb @event.name, occasion_event_path(@occasion, @event)
    add_breadcrumb "Edit Time Slot", edit_occasion_event_event_detail_path(@occasion, @event, @event_detail)
  end

  def update
    @event_detail.update_attributes(event_detail_params)
    @event_detail.start_time = @event_detail.date_started.to_s + ' ' + @event_detail.start_time.strftime('%H:%M')
    @event_detail.end_time = @event_detail.date_started.to_s + ' ' + @event_detail.end_time.strftime('%H:%M')
    authorize @event_detail
    if @event_detail.save
      redirect_to occasion_event_path(@occasion, @event), notice: 'Successfully updated.'
    end
  end

  def destroy
    authorize @event_detail
    @event_detail.destroy
    redirect_to occasion_event_path(@occasion, @event), notice: 'Successfully deleted time slot.'
  end

  private

  def set_occasion
    @occasion = Occasion.find(params[:occasion_id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_detail
    @event_detail = EventDetail.find(params[:id])
  end

  def event_detail_params
    params.require(:event_detail).permit(:capacity, :date_started, :start_time, :end_time)
  end
end

class EventDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_event_detail, except: [:new, :create]
  before_action :set_occasion

  def new
    @event_detail = EventDetail.new
  end

  def create
    @event_details = @event.event_details.new(event_detail_params)
    @event_details.start_time = @event_details.date_started.to_s + " " + @event_details.start_time.strftime("%H:%M")
    @event_details.end_time = @event_details.date_started.to_s + " " + @event_details.end_time.strftime("%H:%M")
    if @event_details.save
      # binding.pry
      redirect_to occasion_event_path(@occasion, @event)
    else
      flash[:errors] = @event_details.errors.full_messages
      redirect_back(fallback_location: new_occasion_event_event_detail_path(@occasion, @event))

    end
  end

  def edit
  end

  def update
    @event_detail.update(event_detail_params)
    redirect_to occasion_event_path(@occasion, @event)
  end

  def destroy
    @event_detail.destroy
    redirect_to occasion_event_path(@occasion, @event)
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

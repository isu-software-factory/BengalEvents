class EventDetailsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_event
  before_action :set_event_detail, except: [:new, :create]
  before_action :set_occasion

  def new
    @event_detail = EventDetail.new
  end

  def create
    @event_detail = EventDetail.new(event_detail_params)
    @event_detail.event = @event

    @event_detail.save
    redirect_to occasion_event_path(@occasion, @event)
  end

  def edit

  end

  def show

  end

  def update
    @event_detail.update(event_detail_params)
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
    params.require(:event_detail).permit(:capacity, :start_time, :end_time)
  end


end

class EventsController < ApplicationController
  before_action :set_occasion, expect: [:index, :show]
  before_action :set_event, except: [:new, :create]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.occasion = @occasion
    @event.save
    redirect_to occasion_path(@occasion)
  end

  def edit
  end

  def update
    @event.update(event_params)
      redirect_to occasion_path(@occasion)
  end

  def destroy
    @event.destroy
    redirect_to occasion_path(@occasion)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_occasion
    @occasion = Occasion.find(params[:occasion_id])
  end

  def event_params
    params.require(:event).permit(:name, :location, :description)
  end
end

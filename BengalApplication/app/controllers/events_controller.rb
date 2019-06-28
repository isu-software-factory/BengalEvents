class EventsController < ApplicationController
  before_action :find_occasion
  before_action :find_event, only: [:destroy]

  def create
    @event = @occasion.events.create(params[:event].permit(:name, :location, :description))
    redirect_to occasion_path(@occasion)
  end

  def destroy
      @event.destroy
      redirect_to occasion_path(@occasion)
  end

  private

  def find_occasion
    @occasion = Occasion.find(params[:occasion_id])
  end

  def find_event
    @event = @occasion.events.find(params[:id])
  end
end

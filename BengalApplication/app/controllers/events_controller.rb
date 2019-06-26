class EventsController < ApplicationController

  def create
    @occasion = Occasion.find(params[:occasion_id])
    @event = @occasion.create(param[:comment].permit(:name, :location,:description, :isMakeAhead))
    redirect_to occasion_path(@occasion)
  end

  def destroy
    @occasion = Occasion.find(params[:occasion_id])
    @event =@occasion.events.find(params[:id])
    @event.destroy
  end
end

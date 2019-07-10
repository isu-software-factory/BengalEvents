class EventsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_occasion, expect: [:index, :show]
  before_action :set_event, except: [:new, :create]
  # after_action :verify_authorized

  def new
    @event = Event.new
    # authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.occasion = @occasion
    # authorize @event
    @event.save
    redirect_to occasion_path(@occasion)
  end

  def edit
  # authorize @event
  end

  def show
    # authorize @event
  end

  def update
    # authorize @event
    @event.update(event_params)
    redirect_to occasion_path(@occasion)
  end

  def destroy
    # authorize @event
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
    params.require(:event).permit(:name, :location, :description, :isMakeAhead)
  end
end

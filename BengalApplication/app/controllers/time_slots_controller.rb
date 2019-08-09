class TimeSlotsController < ApplicationController
  before_action :find_occasion, only: [:new, :create, :destroy, :update, :edit, :show]
  before_action :find_location, only: [:new, :create, :destroy, :update, :edit, :show]
  before_action :find_time_slots, except: [:new, :create]

  def index
    @time_slot = TimeSlot.all
  end

  def new
    @time_slot = TimeSlot.new
    # @location.time_slots.build
  end

  def create
    @time_slot = @location.time_slots.build(time_slots_params)
    if @time_slot.save
      redirect_to occasion_location_path(@occasion, @location)
    else
      flash[:errors] = @time_slot.errors.full_messages
      redirect_back(fallback_location: new_occasion_location_time_slot_path(@occasion, @location))
    end
  end

  def destroy
    @time_slot.destroy
    redirect_to occasion_location_path(@occasion, @location)
  end

end

private

def find_location
  @location = Location.find(params[:location_id])
end

def find_occasion
  @occasion = Occasion.find(params[:occasion_id])
end

def find_time_slots
  @time_slot = TimeSlot.find(params[:id])
end

def time_slots_params
  params.require(:time_slot).permit(:interval, :start_time, :end_time)
end
